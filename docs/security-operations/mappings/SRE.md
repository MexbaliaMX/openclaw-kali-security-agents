# SRE (Site Reliability Engineering) - Kali Linux Tool Mapping

**Agent:** 🛡️ SRE  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 28  
**Status:** Complete

---

## Overview

**Mission:** Ensure system reliability, availability, and performance while implementing security-focused SRE practices.

**Primary Use Cases:**
- System monitoring and alerting
- Incident management and response
- Performance optimization
- Chaos engineering and resilience testing
- Security monitoring integration
- Toil reduction through automation

---

## 1. Monitoring & Observability

### Metrics Collection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **prometheus** | prometheus | Metrics collection | `prometheus --config.file=prometheus.yml` |
| **node-exporter** | prometheus-node-exporter | System metrics | `node_exporter` |
| **grafana-agent** | grafana-agent | Multi-purpose agent | `grafana-agent` |
| **telegraf** | telegraf | Metrics collection | `telegraf --config telegraf.conf` |
| **collectd** | collectd | System statistics | `collectd` |

### Prometheus Configuration
```yaml
# prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

rule_files:
  - 'alerts.yml'
```

### Visualization

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **grafana** | grafana | Dashboards | Web interface (3000) |
| **kibana** | kibana | ES visualization | Web interface (5601) |
| **gnuplot** | gnuplot | Plotting | `gnuplot script.gp` |

---

## 2. Logging & Log Analysis

### Log Aggregation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **fluentd** | fluentd | Log forwarding | `fluentd -c fluent.conf` |
| **fluent-bit** | fluent-bit | Lightweight logging | `fluent-bit -c fluent-bit.conf` |
| **logstash** | logstash | Log processing | `logstash -f pipeline.conf` |
| **rsyslog** | rsyslog | System logging | `rsyslogd` |
| **graylog** | graylog (manual) | Log management | Web interface |

### Log Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **lnav** | lnav | Log navigator | `lnav /var/log/*.log` |
| **multitail** | multitail | Multi-file tail | `multitail /var/log/syslog` |
| **goaccess** | goaccess | Web log analyzer | `goaccess access.log -o report.html` |
| **journalctl** | systemd | Systemd logs | `journalctl -f -u ssh` |

---

## 3. Distributed Tracing

### Tracing Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **jaeger** | jaeger (manual) | Distributed tracing | `jaeger-all-in-one` |
| **zipkin** | zipkin (manual) | Tracing system | `java -jar zipkin.jar` |
| **opentelemetry** | opentelemetry (manual) | Observability framework | SDK integration |
| **tempo** | tempo (manual) | Grafana tracing | `tempo` |

---

## 4. Alerting & On-Call

### Alerting Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **alertmanager** | prometheus-alertmanager | Alert routing | `alertmanager --config.file=am.yml` |
| **opsgenie** | opsgenie (manual) | On-call management | Web/API |
| **pagerduty** | pagerduty (manual) | Incident management | Web/API |

### Alertmanager Configuration
```yaml
# alertmanager.yml
route:
  receiver: 'default'
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 4h

receivers:
  - name: 'default'
    email_configs:
      - to: 'oncall@company.com'
        from: 'alertmanager@company.com'
        smarthost: 'smtp.company.com:587'
```

---

## 5. Chaos Engineering

### Chaos Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **chaos-mesh** | chaos-mesh (manual) | Kubernetes chaos | `kubectl apply -f experiment.yaml` |
| **litmus** | litmus (manual) | Cloud-native chaos | `litmuschaos` |
| **chaos-toolkit** | chaos-toolkit (pip) | Chaos testing | `chaos run experiment.json` |
| **pumba** | pumba (manual) | Docker chaos | `pumba netem --duration 60s` |
| **toxiproxy** | toxiproxy (manual) | Network chaos | `toxiproxy-server` |

### Chaos Experiment Example
```json
{
  "version": "1.0.0",
  "title": "Network latency experiment",
  "description": "Add 200ms latency to database connections",
  "tags": ["network", "database"],
  "steady-state-hypothesis": {
    "title": "Service responds normally",
    "probes": [
      {
        "type": "probe",
        "name": "health-check",
        "tolerance": true,
        "provider": {
          "type": "http",
          "url": "http://service/health"
        }
      }
    ]
  },
  "method": [
    {
      "type": "action",
      "name": "add-latency",
      "provider": {
        "type": "process",
        "path": "toxiproxy-cli",
        "arguments": {
          "toxic": "latency",
          "latency": 200
        }
      }
    }
  ]
}
```

---

## 6. Security Monitoring Integration

### Runtime Security

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **falco** | falco | Runtime security | `falco --config falco_rules.yaml` |
| **sysdig** | sysdig | System visibility | `sysdig -c echo_fds` |
| **tracee** | tracee (manual) | Container tracing | `tracee-ebpf` |
| **tetragon** | tetragon (manual) | eBPF security | `tetragon` |

### Falco Rules Example
```yaml
- rule: Unexpected System Call
  desc: Detect unexpected system calls in containers
  condition: (container.id != host) and (proc.name in (nc, ncat, netcat))
  output: "Unexpected network tool in container (user=%user.name container=%container.id)"
  priority: WARNING
  tags: [container, security]

- rule: Sensitive File Access
  desc: Access to sensitive files
  condition: (evt.type = open) and (fd.name contains "/etc/shadow")
  output: "Sensitive file access (user=%user.name file=%fd.name)"
  priority: ERROR
  tags: [filesystem, sensitive]
```

---

## 7. Automation & Toil Reduction

### Automation Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **ansible** | ansible | Configuration mgmt | `ansible-playbook playbook.yml` |
| **terraform** | terraform | Infrastructure as code | `terraform apply` |
| **pulumi** | pulumi (manual) | IaC (multi-language) | `pulumi up` |
| **n8n** | n8n (manual) | Workflow automation | Web interface |
| **stackstorm** | stackstorm (manual) | Event-driven automation | Web interface |

---

## 8. Performance Testing

### Load Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **k6** | k6 (manual) | Load testing | `k6 run script.js` |
| **locust** | locust (pip) | Load testing | `locust -f locustfile.py` |
| **wrk** | wrk | HTTP benchmarking | `wrk -t12 -c400 -d30s http://target` |
| **ab** | apache2-utils | Apache benchmark | `ab -n 1000 -c 10 http://target/` |
| **jmeter** | jmeter (manual) | Load testing | GUI application |

### k6 Example
```javascript
// script.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 100,
  duration: '30s',
};

export default function () {
  const res = http.get('http://target/api/health');
  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 200ms': (r) => r.timings.duration < 200,
  });
  sleep(1);
}
```

---

## Top 10 SRE Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Prometheus** | Metrics | Industry-standard monitoring |
| 2 | **Grafana** | Visualization | Dashboard platform |
| 3 | **Fluentd** | Logging | Log aggregation |
| 4 | **Jaeger** | Tracing | Distributed tracing |
| 5 | **Alertmanager** | Alerting | Alert routing |
| 6 | **Falco** | Security | Runtime security |
| 7 | **Chaos Mesh** | Chaos | Kubernetes chaos |
| 8 | **k6** | Performance | Modern load testing |
| 9 | **Ansible** | Automation | Configuration management |
| 10 | **Sysdig** | Visibility | System visibility |

---

## Quick Reference Commands

### Prometheus Queries
```promql
# CPU usage
100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Memory usage
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100

# Disk usage
(1 - (node_filesystem_avail_bytes / node_filesystem_size_bytes)) * 100

# Request rate
rate(http_requests_total[5m])

# Error rate
rate(http_requests_total{status=~"5.."}[5m])
```

### Grafana Dashboard Setup
```bash
# Start Grafana
systemctl start grafana-server

# Access web interface
# http://localhost:3000 (admin/admin)

# Import dashboards
# Use dashboard IDs from grafana.com/dashboards
```

### Chaos Engineering
```bash
# Start chaos-mesh
kubectl apply -f https://mirrors.chaos-mesh.org/latest/chaos-mesh.yaml

# Run experiment
kubectl apply -f network-delay.yaml

# View experiments
kubectl get chaos-experiments
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Monitoring** | Prometheus, Grafana |
| **Logging** | Fluentd, Logstash, rsyslog |
| **Security** | Falco, Sysdig |
| **Automation** | Ansible |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Jaeger** | Docker/binary | Distributed tracing |
| **Zipkin** | Docker/JAR | Tracing system |
| **Chaos Mesh** | Kubernetes | Chaos engineering |
| **Litmus** | Kubernetes | Cloud-native chaos |
| **k6** | Download binary | Load testing |
| **Locust** | pip | Load testing |
| **n8n** | npm/Docker | Workflow automation |
| **StackStorm** | apt/Docker | Event-driven automation |

---

## SRE Metrics (Golden Signals)

| Signal | Description | Target |
|--------|-------------|--------|
| **Latency** | Time to process requests | <200ms (p95) |
| **Traffic** | Requests per second | Monitor trends |
| **Errors** | Error rate | <0.1% |
| **Saturation** | Resource utilization | <80% |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly  
**Owner:** Security Team
