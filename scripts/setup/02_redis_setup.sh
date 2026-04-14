#!/bin/bash
# RL Mechanism - Redis Setup Script
# Version: 1.0
# Date: April 14, 2026
# Description: Install and configure Redis for RL mechanism

set -e

echo "=========================================="
echo "RL Mechanism - Redis Setup"
echo "=========================================="

# Configuration
REDIS_PASSWORD="${RL_REDIS_PASSWORD:-$(openssl rand -base64 32)}"
REDIS_PORT=6379
REDIS_TLS_PORT=6380
REDIS_MAXMEMORY="512mb"

echo ""
echo "Configuration:"
echo "  Password: [REDACTED - save from RL_REDIS_PASSWORD env var]"
echo "  Port: $REDIS_PORT (disabled for non-TLS)"
echo "  TLS Port: $REDIS_TLS_PORT"
echo "  Max Memory: $REDIS_MAXMEMORY"
echo ""

# Check if Redis is installed
if ! command -v redis-server &> /dev/null; then
    echo "Installing Redis..."
    sudo apt update
    sudo apt install -y redis-server
else
    echo "Redis already installed"
    redis-server --version
fi

# Generate TLS certificates for Redis
echo ""
echo "Generating TLS certificates..."
TLS_DIR="/etc/redis/tls"
sudo mkdir -p $TLS_DIR

# Generate CA
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -sha256 -key ca.key -days 3650 -out ca.crt \
    -subj "/C=US/ST=California/L=San Francisco/O=RL Mechanism/CN=RL-CA"

# Generate server certificate (2 years validity)
openssl genrsa -out redis.key 2048
openssl req -new -sha256 -key redis.key -out redis.csr \
    -subj "/C=US/ST=California/L=San Francisco/O=RL Mechanism/CN=localhost"
openssl x509 -req -sha256 -in redis.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
    -out redis.crt -days 730

# Move certificates to Redis directory
sudo mv ca.crt redis.crt redis.key $TLS_DIR/
sudo chown redis:redis $TLS_DIR/*
sudo chmod 600 $TLS_DIR/redis.key
sudo chmod 644 $TLS_DIR/redis.crt
sudo chmod 644 $TLS_DIR/ca.crt

# Clean up local copies
rm -f ca.key ca.crt redis.key redis.csr redis.crt ca.srl

# Configure Redis
echo ""
echo "Configuring Redis for RL workload..."

REDIS_CONF="/etc/redis/redis.conf"

# Backup original config
sudo cp $REDIS_CONF ${REDIS_CONF}.backup

# Create new config with RL-specific settings
sudo tee $REDIS_CONF > /dev/null <<EOF
# RL Mechanism - Redis Configuration

# Network
bind 127.0.0.1
port 0  # Disable non-TLS port
tls-port $REDIS_TLS_PORT
tls-cert-file $TLS_DIR/redis.crt
tls-key-file $TLS_DIR/redis.key
tls-ca-cert-file $TLS_DIR/ca.crt
tls-auth-clients optional

# Security
requirepass $REDIS_PASSWORD
acl setuser default on >$REDIS_PASSWORD ~* &* +@all

# Memory
maxmemory $REDIS_MAXMEMORY
maxmemory-policy allkeys-lru

# Persistence
save 900 1
save 300 10
save 60 10000
dbfilename dump.rdb
dir /var/lib/redis

# Logging
loglevel notice
logfile /var/log/redis/redis-server.log

# Performance
tcp-backlog 511
timeout 0
tcp-keepalive 300

# RL Mechanism specific
# Enable keyspace notifications for pub/sub
notify-keyspace-events Ex

# Slow log (for performance debugging)
slowlog-log-slower-than 10000
slowlog-max-len 128
EOF

# Set proper ownership
sudo chown redis:redis $REDIS_CONF

# Restart Redis
echo "Restarting Redis..."
sudo systemctl restart redis-server

# Verify installation
echo ""
echo "Verifying installation..."
sleep 2  # Wait for Redis to start

# Test connection with TLS
if redis-cli -h localhost -p $REDIS_TLS_PORT --tls \
    --cacert $TLS_DIR/ca.crt --cert $TLS_DIR/redis.crt --key $TLS_DIR/redis.key \
    -a $REDIS_PASSWORD PING 2>/dev/null | grep -q "PONG"; then
    echo "✅ Redis TLS connection successful"
else
    echo "❌ Redis TLS connection failed"
    exit 1
fi

# Save credentials to file
CREDENTIALS_FILE=".rl_redis_credentials"
cat > $CREDENTIALS_FILE <<EOF
# RL Mechanism - Redis Credentials
# Generated: $(date)
# DO NOT COMMIT THIS FILE TO GIT

REDIS_HOST=localhost
REDIS_TLS_PORT=$REDIS_TLS_PORT
REDIS_PASSWORD=$REDIS_PASSWORD
REDIS_CONNECTION_STRING=rediss://:$REDIS_PASSWORD@localhost:$REDIS_TLS_PORT
REDIS_TLS_CA=$TLS_DIR/ca.crt
REDIS_TLS_CERT=$TLS_DIR/redis.crt
REDIS_TLS_KEY=$TLS_DIR/redis.key
EOF

chmod 600 $CREDENTIALS_FILE

echo ""
echo "=========================================="
echo "Redis Setup Complete!"
echo "=========================================="
echo ""
echo "Credentials saved to: $CREDENTIALS_FILE"
echo "⚠️  IMPORTANT: Save the password securely and delete this file after copying"
echo ""
echo "Connection string:"
echo "  rediss://:[PASSWORD]@localhost:$REDIS_TLS_PORT"
echo ""
echo "Test commands:"
echo "  redis-cli -h localhost -p $REDIS_TLS_PORT --tls \\"
echo "    --cacert $TLS_DIR/ca.crt \\"
echo "    --cert $TLS_DIR/redis.crt \\"
echo "    --key $TLS_DIR/redis.key \\"
echo "    -a $REDIS_PASSWORD PING"
echo ""
echo "Next steps:"
echo "  1. Copy credentials to secure location"
echo "  2. Delete $CREDENTIALS_FILE"
echo "  3. Proceed to OpenTelemetry setup (scripts/setup/03_opentelemetry_setup.sh)"
echo ""
