#!/bin/bash
# Quick Install Script - Copy and paste each section

echo "=== Installing Missing Tools ==="
echo ""

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker.io

# Install Nuclei
echo "Installing Nuclei..."
sudo apt install -y nuclei

# Install XCA
echo "Installing XCA..."
sudo apt install -y xca

# Install Python tools
echo "Installing Python tools..."
sudo pip3 install --break-system-packages volatility3 prowler scout-suite slither-analyzer mythril jwt-tool

# Install Foundry
echo "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash

echo ""
echo "=== Installation Complete ==="
echo "Run: source ~/.bashrc && foundryup"
