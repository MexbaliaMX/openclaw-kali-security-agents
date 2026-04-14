#!/bin/bash
# RL Mechanism - OpenTelemetry Setup Script
# Version: 1.0
# Date: April 14, 2026
# Description: Install and configure OpenTelemetry Collector for RL mechanism

set -e

echo "=========================================="
echo "RL Mechanism - OpenTelemetry Setup"
echo "=========================================="

# Configuration
OTEL_VERSION="0.95.0"
OTEL_GRPC_PORT=4317
OTEL_HTTP_PORT=4318
PROMETHEUS_PORT=8889
JAEGER_PORT=14250

echo ""
echo "Configuration:"
echo "  OTLP gRPC Port: $OTEL_GRPC_PORT"
echo "  OTLP HTTP Port: $OTEL_HTTP_PORT"
echo "  Prometheus Export Port: $PROMETHEUS_PORT"
echo "  Jaeger gRPC Port: $JAEGER_PORT"
echo ""

# Check if OpenTelemetry Collector is installed
if ! command -v otelcol-contrib &> /dev/null; then
    echo "Installing OpenTelemetry Collector..."
    cd /tmp
    wget -q https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTEL_VERSION}/otelcol-contrib_${OTEL_VERSION}_linux_amd64.deb
    sudo dpkg -i otelcol-contrib_${OTEL_VERSION}_linux_amd64.deb
    rm -f otelcol-contrib_${OTEL_VERSION}_linux_amd64.deb
    cd -
else
    echo "OpenTelemetry Collector already installed"
    otelcol-contrib --version
fi

# Create configuration directory
OTEL_CONF_DIR="/etc/otelcol-contrib"
sudo mkdir -p $OTEL_CONF_DIR

# Create OpenTelemetry Collector configuration
echo ""
echo "Creating OpenTelemetry Collector configuration..."

sudo tee /etc/otelcol-contrib/config.yaml > /dev/null <<EOF
# RL Mechanism - OpenTelemetry Collector Configuration

receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:$OTEL_GRPC_PORT
      http:
        endpoint: 0.0.0.0:$OTEL_HTTP_PORT

processors:
  batch:
    timeout: 1s
    send_batch_size: 1024
    send_batch_max_size: 2048
  memory_limiter:
    check_interval: 1s
    limit_mib: 4000
    spike_limit_mib: 1000
  resource:
    attributes:
      - key: service.namespace
        value: rl-mechanism
        action: upsert
      - key: deployment.environment
        value: production
        action: upsert

exporters:
  prometheus:
    endpoint: "0.0.0.0:$PROMETHEUS_PORT"
    namespace: rl
    resource_to_telemetry_conversion:
      enabled: true
  
  otlp/jaeger:
    endpoint: localhost:$JAEGER_PORT
    tls:
      insecure: true
  
  debug:
    verbosity: detailed

service:
  telemetry:
    logs:
      level: info
    metrics:
      address: localhost:8888
  
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch, memory_limiter, resource]
      exporters: [otlp/jaeger, debug]
    
    metrics:
      receivers: [otlp]
      processors: [batch, memory_limiter, resource]
      exporters: [prometheus, debug]
    
    logs:
      receivers: [otlp]
      processors: [batch, memory_limiter, resource]
      exporters: [debug]
EOF

# Enable and start OpenTelemetry Collector
echo "Starting OpenTelemetry Collector..."
sudo systemctl enable otelcol-contrib
sudo systemctl start otelcol-contrib

# Wait for collector to start
sleep 3

# Verify installation
echo ""
echo "Verifying installation..."

if sudo systemctl is-active --quiet otelcol-contrib; then
    echo "✅ OpenTelemetry Collector is running"
else
    echo "❌ OpenTelemetry Collector failed to start"
    sudo systemctl status otelcol-contrib
    exit 1
fi

# Check if ports are listening
echo ""
echo "Checking listening ports..."
sudo ss -tlnp | grep -E "$OTEL_GRPC_PORT|$OTEL_HTTP_PORT|$PROMETHEUS_PORT" || echo "⚠️  Ports may still be starting up"

# Create Grafana datasource configuration
echo ""
echo "Creating Grafana datasource configuration..."

GRAFANA_DATASOURCES_DIR="/etc/grafana/provisioning/datasources"
sudo mkdir -p $GRAFANA_DATASOURCES_DIR

sudo tee $GRAFANA_DATASOURCES_DIR/rl-mechanism.yaml > /dev/null <<EOF
apiVersion: 1

datasources:
  - name: Prometheus - RL Mechanism
    type: prometheus
    access: proxy
    url: http://localhost:$PROMETHEUS_PORT
    isDefault: true
    editable: true
    jsonData:
      timeInterval: "15s"
      queryTimeout: "60s"
EOF

# Create Grafana dashboards directory
GRAFANA_DASHBOARDS_DIR="/etc/grafana/provisioning/dashboards"
sudo mkdir -p $GRAFANA_DASHBOARDS_DIR

sudo tee $GRAFANA_DASHBOARDS_DIR/rl-mechanism.yaml > /dev/null <<EOF
apiVersion: 1

providers:
  - name: 'RL Mechanism'
    orgId: 1
    folder: 'RL Mechanism'
    folderUid: 'rl-mechanism'
    type: file
    disableDeletion: false
    updateIntervalSeconds: 30
    options:
      path: /etc/grafana/dashboards/rl-mechanism
EOF

# Create dashboard directory
sudo mkdir -p /etc/grafana/dashboards/rl-mechanism

echo ""
echo "=========================================="
echo "OpenTelemetry Setup Complete!"
echo "=========================================="
echo ""
echo "Ports:"
echo "  OTLP gRPC: $OTEL_GRPC_PORT"
echo "  OTLP HTTP: $OTEL_HTTP_PORT"
echo "  Prometheus Metrics: $PROMETHEUS_PORT"
echo "  Jaeger gRPC: $JAEGER_PORT"
echo ""
echo "Next steps:"
echo "  1. Import Grafana dashboards (dashboards/grafana/)"
echo "  2. Instrument application with OpenTelemetry SDK"
echo "  3. Verify traces in Jaeger (http://localhost:16686)"
echo "  4. Verify metrics in Grafana (http://localhost:3000)"
echo ""
echo "Test instrumentation:"
echo "  Python example:"
echo "    from opentelemetry import trace"
echo "    from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter"
echo "    trace.set_tracer_provider(TracerProvider())"
echo "    trace.get_tracer_provider().add_span_processor("
echo "      BatchSpanProcessor(OTLPSpanExporter(endpoint='localhost:$OTEL_GRPC_PORT', insecure=True))"
echo "    )"
echo ""
