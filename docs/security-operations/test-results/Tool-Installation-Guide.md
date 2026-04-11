# Tool Installation Guide - Phase 2

**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Purpose:** Install missing tools identified in Phase 2 testing  
**Status:** Ready for execution

---

## Summary

| Metric | Value |
|--------|-------|
| **Tools to Install** | 10 |
| **Categories** | 6 (Forensics, Web, Dev, Cloud, Blockchain, Identity) |
| **Estimated Time** | 30-45 minutes |
| **Disk Space** | ~5GB |

---

## Quick Install Script

```bash
#!/bin/bash
# install-missing-tools.sh
# Install all missing tools from Phase 2 testing

echo "=== Installing Missing Tools ==="
echo "Date: $(date)"
echo ""

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
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup

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
```

---

## Individual Installation Instructions

### 1. Volatility3 (Forensics)

**Category:** Memory Forensics  
**Priority:** HIGH  
**Install Time:** 2-3 minutes

```bash
# Install via pip
pip3 install --break-system-packages volatility3

# Verify installation
volatility3 --version

# Test basic command
volatility3 --help
```

**Usage Example:**
```bash
# Analyze memory dump
volatility3 -f memory.dump windows.pslist
```

---

### 2. Nuclei (Web Scanner)

**Category:** Web Security  
**Priority:** HIGH  
**Install Time:** 2-3 minutes

```bash
# Install via apt
apt update
apt install -y nuclei

# Verify installation
nuclei -version

# Update templates
nuclei -ut
```

**Usage Example:**
```bash
# Scan target
nuclei -u https://target.com -t vulnerabilities/

# Scan with specific severity
nuclei -u https://target.com -t http -severity critical,high
```

---

### 3. Docker (Development)

**Category:** Containerization  
**Priority:** HIGH  
**Install Time:** 5-10 minutes

```bash
# Install Docker
apt update
apt install -y docker.io

# Start and enable service
systemctl start docker
systemctl enable docker

# Add user to docker group (optional, for non-root access)
usermod -aG docker $USER

# Verify installation
docker --version
docker run hello-world
```

**Usage Example:**
```bash
# Run CALDERA for Purple Team
docker run -p 8888:8888 mitre/caldera

# Run security scanner container
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image nginx:latest
```

---

### 4. Prowler (Cloud Security)

**Category:** Cloud Auditing (AWS)  
**Priority:** MEDIUM  
**Install Time:** 2-3 minutes

```bash
# Install via pip
pip3 install --break-system-packages prowler

# Verify installation
prowler --version

# Configure AWS credentials (required)
aws configure
```

**Usage Example:**
```bash
# Run CIS benchmark
prowler -c cis

# Run all checks with HTML report
prowler -M html,json -o ./reports
```

**Requirements:**
- AWS credentials configured
- AWS CLI installed (`apt install awscli`)

---

### 5. ScoutSuite (Multi-Cloud)

**Category:** Cloud Auditing  
**Priority:** MEDIUM  
**Install Time:** 2-3 minutes

```bash
# Install via pip
pip3 install --break-system-packages scout-suite

# Verify installation
scout --version

# Install cloud CLIs (as needed)
apt install -y awscli  # AWS
# azure-cli           # Azure (separate install)
# gcloud              # GCP (separate install)
```

**Usage Example:**
```bash
# AWS audit
scout run aws

# Azure audit
scout run azure

# GCP audit
scout run gcp
```

---

### 6. Slither (Blockchain)

**Category:** Smart Contract Analysis  
**Priority:** MEDIUM  
**Install Time:** 3-5 minutes

```bash
# Install via pip
pip3 install --break-system-packages slither-analyzer

# Verify installation
slither --version

# Install Solidity compiler (required)
apt install -y solc
```

**Usage Example:**
```bash
# Analyze smart contract
slither ./contracts/MyContract.sol

# Generate JSON report
slither ./contracts/ --json output.json
```

**Requirements:**
- Python 3.8+
- Solidity compiler (solc)

---

### 7. Mythril (Blockchain)

**Category:** Smart Contract Security  
**Priority:** MEDIUM  
**Install Time:** 5-10 minutes

```bash
# Install via pip
pip3 install --break-system-packages mythril

# Verify installation
myth --version

# Install dependencies
apt install -y build-essential python3-dev
```

**Usage Example:**
```bash
# Analyze contract
myth analyze MyContract.sol

# Analyze bytecode
myth analyze 0x1234567890abcdef
```

**Requirements:**
- Python 3.8+
- Ethereum dependencies (installed automatically)

---

### 8. Foundry (Blockchain)

**Category:** Smart Contract Development  
**Priority:** HIGH  
**Install Time:** 5-10 minutes

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash

# Load new shell configuration
source ~/.bashrc

# Install Foundry tools
foundryup

# Verify installation
forge --version
cast --version
anvil --version
chisel --version
```

**Usage Example:**
```bash
# Create new project
forge init my-project

# Run tests
forge test

# Deploy contract
forge create --rpc-url <URL> --private-key <KEY> src/Contract.sol:Contract
```

**Tools Included:**
- `forge` - Build and test
- `cast` - Interact with contracts
- `anvil` - Local blockchain
- `chisel` - Solidity REPL

---

### 9. JWT-Tool (Identity)

**Category:** Authentication Testing  
**Priority:** MEDIUM  
**Install Time:** 2-3 minutes

```bash
# Install via pip
pip3 install --break-system-packages jwt-tool

# Verify installation
jwt-tool --help

# Test basic command
jwt-tool --version
```

**Usage Example:**
```bash
# Analyze token
jwt-tool eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Test all attacks
jwt-tool TOKEN --test-all

# Forge new token
jwt-tool --payload '{"admin":true}' --secret secret
```

---

### 10. XCA (PKI)

**Category:** Certificate Authority  
**Priority:** LOW  
**Install Time:** 2-3 minutes

```bash
# Install via apt
apt update
apt install -y xca

# Verify installation
xca --version

# Or launch GUI
xca
```

**Usage Example:**
```bash
# Launch GUI
xca

# Create CA:
# 1. File → New Database
# 2. Certificates → New Certificate
# 3. Select template (CA)
# 4. Generate and export
```

---

## Post-Installation Verification

### Run Verification Script

```bash
#!/bin/bash
# verify-installations.sh

echo "=== Verifying Tool Installations ==="
echo ""

tools=(
    "volatility3"
    "nuclei"
    "docker"
    "prowler"
    "scout"
    "slither"
    "myth"
    "forge"
    "jwt"
    "xca"
)

installed=0
missing=0

for tool in "${tools[@]}"; do
    if command -v $tool &> /dev/null; then
        echo "✅ $tool: INSTALLED"
        $tool --version 2>&1 | head -1 || echo "   (GUI tool or version not available)"
        ((installed++))
    else
        echo "❌ $tool: NOT FOUND"
        ((missing++))
    fi
done

echo ""
echo "=== Summary ==="
echo "Installed: $installed / ${#tools[@]}"
echo "Missing: $missing / ${#tools[@]}"
echo "Success Rate: $((installed * 100 / ${#tools[@]}))%"
```

---

## Troubleshooting

### Common Issues

#### pip install fails
```bash
# Use --break-system-packages flag
pip3 install --break-system-packages <package>

# Or use virtual environment
python3 -m venv venv
source venv/bin/activate
pip install <package>
```

#### Docker permission denied
```bash
# Add user to docker group
usermod -aG docker $USER
newgrp docker

# Or run with sudo
sudo docker ps
```

#### Foundry not found after install
```bash
# Source bashrc
source ~/.bashrc

# Or add to PATH manually
export PATH="$HOME/.foundry/bin:$PATH"
```

#### AWS credentials not configured
```bash
# Configure AWS CLI
aws configure

# Or set environment variables
export AWS_ACCESS_KEY_ID=<your-key>
export AWS_SECRET_ACCESS_KEY=<your-secret>
```

---

## Installation Priority

| Priority | Tools | Reason |
|----------|-------|--------|
| **HIGH** | Docker, Nuclei, Foundry, Volatility3 | Core functionality |
| **MEDIUM** | Prowler, ScoutSuite, Slither, Mythril, JWT-Tool | Specialized testing |
| **LOW** | XCA | GUI tool, specific use cases |

---

## Disk Space Requirements

| Tool | Estimated Size |
|------|----------------|
| Docker | 2-3 GB |
| Foundry | 500 MB |
| Nuclei | 100 MB |
| Volatility3 | 50 MB |
| Prowler | 50 MB |
| ScoutSuite | 50 MB |
| Slither | 100 MB |
| Mythril | 200 MB |
| JWT-Tool | 10 MB |
| XCA | 50 MB |
| **TOTAL** | **~5 GB** |

---

## Estimated Installation Time

| Phase | Tools | Time |
|-------|-------|------|
| **System Updates** | apt update/upgrade | 5-10 min |
| **Docker** | docker.io | 5-10 min |
| **Python Tools** | 7 tools via pip | 10-15 min |
| **Foundry** | curl + foundryup | 5-10 min |
| **APT Tools** | nuclei, xca | 5 min |
| **Verification** | All tools | 5 min |
| **TOTAL** | | **30-45 min** |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Status:** Ready for execution  
**Next Action:** Run install script or install individually
