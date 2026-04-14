#!/bin/bash
# RL Mechanism - PostgreSQL Setup Script
# Version: 1.0
# Date: April 14, 2026
# Description: Install and configure PostgreSQL for RL mechanism

set -e

echo "=========================================="
echo "RL Mechanism - PostgreSQL Setup"
echo "=========================================="

# Configuration
DB_NAME="rl_mechanism"
DB_USER="rl_app"
DB_PASSWORD="${RL_POSTGRES_PASSWORD:-$(openssl rand -base64 32)}"
POSTGRES_VERSION="15"

echo ""
echo "Configuration:"
echo "  Database: $DB_NAME"
echo "  User: $DB_USER"
echo "  Password: [REDACTED - save from RL_POSTGRES_PASSWORD env var]"
echo "  PostgreSQL Version: $POSTGRES_VERSION"
echo ""

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "Installing PostgreSQL..."
    sudo apt update
    sudo apt install -y postgresql postgresql-contrib pgvector
else
    echo "PostgreSQL already installed"
    psql --version
fi

# Start PostgreSQL if not running
if ! sudo systemctl is-active --quiet postgresql; then
    echo "Starting PostgreSQL..."
    sudo systemctl start postgresql
fi

# Create database and user
echo ""
echo "Creating database and user..."
sudo -u postgres psql <<EOF
-- Create database
CREATE DATABASE $DB_NAME;

-- Create user with encrypted password
CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASSWORD';

-- Grant permissions
GRANT CONNECT ON DATABASE $DB_NAME TO $DB_USER;
GRANT USAGE ON SCHEMA public TO $DB_USER;
EOF

# Run migrations
echo ""
echo "Running database migrations..."
if ! sudo -u postgres psql -d $DB_NAME -f scripts/db/migrations/001_initial_schema.sql; then
    echo "❌ Migration failed!"
    exit 1
fi
echo "✅ Migration completed successfully"

# Grant permissions on new tables
sudo -u postgres psql -d $DB_NAME <<EOF
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO $DB_USER;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;
EOF

# Configure PostgreSQL for RL workload
echo ""
echo "Configuring PostgreSQL for RL workload..."

PG_CONF="/etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf"

# Backup original config
sudo cp $PG_CONF ${PG_CONF}.backup

# Append RL-specific settings
sudo tee -a $PG_CONF > /dev/null <<EOF

# RL Mechanism Configuration
shared_preload_libraries = 'pgaudit'
work_mem = 64MB
effective_cache_size = 4GB
maintenance_work_mem = 256MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
EOF

# Restart PostgreSQL to apply changes
echo "Restarting PostgreSQL..."
sudo systemctl restart postgresql

# Verify installation
echo ""
echo "Verifying installation..."
sudo -u postgres psql -d $DB_NAME <<EOF
SELECT 'Database: ' || current_database() as status;
SELECT 'Tables: ' || COUNT(*)::text FROM information_schema.tables WHERE table_schema = 'public';
SELECT 'Extensions: ' || string_agg(extname, ', ') FROM pg_extension;
EOF

# Save credentials to file
CREDENTIALS_FILE=".rl_postgres_credentials"
cat > $CREDENTIALS_FILE <<EOF
# RL Mechanism - PostgreSQL Credentials
# Generated: $(date)
# DO NOT COMMIT THIS FILE TO GIT

DB_HOST=localhost
DB_PORT=5432
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
DB_CONNECTION_STRING=postgresql://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME
EOF

chmod 600 $CREDENTIALS_FILE

echo ""
echo "=========================================="
echo "PostgreSQL Setup Complete!"
echo "=========================================="
echo ""
echo "Credentials saved to: $CREDENTIALS_FILE"
echo "⚠️  IMPORTANT: Save the password securely and delete this file after copying"
echo "⚠️  Password will be cleared from screen in 10 seconds..."
echo ""
echo "Connection string:"
echo "  postgresql://$DB_USER:[PASSWORD]@localhost:5432/$DB_NAME"
echo ""
sleep 10
clear
echo "✅ Password cleared from screen"
echo ""
echo "Next steps:"
echo "  1. Copy credentials from $CREDENTIALS_FILE to secure location"
echo "  2. Delete $CREDENTIALS_FILE (rm $CREDENTIALS_FILE)"
echo "  3. Proceed to Redis setup (scripts/setup/02_redis_setup.sh)"
echo ""
