#!/bin/bash
# install-missing-tools.sh
# Install all missing tools from Phase 2 testing
# Run with: sudo bash install-missing-tools.sh

echo "=== Installing Missing Tools ==="
echo "Date: $(date)"
echo "User: $(whoami)"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run as root or with sudo"
    echo "Usage: sudo bash $0"
    exit 1
fi

# Update system
echo "[1/10] Updating system..."
apt update && apt upgrade -y

# Docker
echo "[2/10] Installing Docker..."
apt install -y docker.io
systemctl start docker
systemctl enable docker

# Nuclei
echo "[3/10] Installing Nuclei..."
apt install -y nuclei

# XCA
echo "[4/10] Installing XCA..."
apt install -y xca

# Python tools
echo "[5/10] Installing Python security tools..."
pip3 install --break-system-packages \
    volatility3 \
    prowler \
    scout-suite \
    slither-analyzer \
    mythril \
    jwt-tool

# Foundry (Blockchain)
echo "[6/10] Installing Foundry..."
if [ "$SUDO_USER" ]; then
    su - $SUDO_USER -c "curl -L https://foundry.paradigm.xyz | bash"
    su - $SUDO_USER -c "source ~/.bashrc && foundryup"
else
    curl -L https://foundry.paradigm.xyz | bash
    source ~/.bashrc
    foundryup
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Verifying installations..."

# Verify all tools
echo ""
echo "=== Verification ==="
which volatility3 && echo "✅ Volatility3" || echo "❌ Volatility3"
which nuclei && echo "✅ Nuclei" || echo "❌ Nuclei"
which docker && echo "✅ Docker" || echo "❌ Docker"
which prowler && echo "✅ Prowler" || echo "❌ Prowler"
which scout && echo "✅ ScoutSuite" || echo "❌ ScoutSuite"
which slither && echo "✅ Slither" || echo "❌ Slither"
which myth && echo "✅ Mythril" || echo "❌ Mythril"
which forge && echo "✅ Foundry" || echo "❌ Foundry"
which jwt && echo "✅ JWT-Tool" || echo "❌ JWT-Tool"
which xca && echo "✅ XCA" || echo "❌ XCA"

echo ""
echo "=== Installation Guide Complete ==="
echo ""
echo "To use Docker without sudo, run:"
echo "  usermod -aG docker \$USER"
echo "  newgrp docker"
echo ""
