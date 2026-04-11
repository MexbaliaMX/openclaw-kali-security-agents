# Security Engineer - Kali Linux Tool Mapping

**Agent:** 🔒 Security Engineer  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 48  
**Status:** Complete

---

## Overview

**Mission:** Design secure architectures, implement security controls, and ensure proper hardening across systems and applications.

**Primary Use Cases:**
- Security architecture design
- System hardening and configuration
- Network security implementation
- Cryptography and key management
- Container and cloud security
- Security control validation

---

## 1. Security Auditing & Hardening

### System Auditing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **lynis** | lynis | Security auditing | `lynis audit system` |
| **openscap** | openscap-scanner | Compliance scanning | `oscap xccdf eval --profile cis sds.xml` |
| **cis-cat** | cis-cat (manual) | CIS benchmarking | Java application |
| **tiger** | tiger | Security checker | `tiger` |
| **bastille** | bastille | Hardening tool | `bastille` (interactive) |
| **jazz** | jazz (manual) | Security assessment | `jazz -t target` |

### Lynis Usage Examples
```bash
# Full system audit
lynis audit system

# Specific audit category
lynis audit system remote

# Generate report
lynis audit system --report-file /tmp/report.txt

# Quick scan
lynis show all

# View specific tests
lynis show tests --group=malware
```

### OpenSCAP Examples
```bash
# List available profiles
oscap info /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Run CIS benchmark scan
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results scan-results.xml \
  --report report.html \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Run STIG scan
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_stig \
  --results stig-results.xml \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml
```

---

## 2. Network Security

### Firewall Management

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **iptables** | iptables | Packet filtering | `iptables -L -n -v` |
| **nftables** | nftables | Next-gen firewall | `nft list ruleset` |
| **ufw** | ufw | Uncomplicated firewall | `ufw status verbose` |
| **firewalld** | firewalld | Dynamic firewall | `firewall-cmd --list-all` |
| **pfsense** | pfsense (manual) | Firewall distribution | Web interface |
| **opnsense** | opnsense (manual) | Firewall distribution | Web interface |

### Network Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **nmap** | nmap | Network mapper | `nmap -sV -sC -oA scan target` |
| **masscan** | masscan | Fast port scanner | `masscan -p1-65535 target --rate 1000` |
| **netcat** | netcat | Network swiss knife | `nc -zv target 22` |
| **socat** | socat | Multipurpose relay | `socat TCP-LISTEN:8080,fork TCP:target:80` |
| **tcpdump** | tcpdump | Packet capture | `tcpdump -i eth0 -w capture.pcap` |
| **wireshark** | wireshark | Protocol analyzer | `wireshark -i eth0` |
| **ss** | iproute2 | Socket statistics | `ss -tulpn` |
| **netstat** | net-tools | Network statistics | `netstat -tulpn` |

### Network Segmentation Design
```bash
# Verify VLAN configuration
ip -d link show

# Check routing table
ip route show

# Verify firewall rules
iptables -L -n -v --line-numbers

# Test segmentation
nmap -sS -Pn segmented_network/24

# Monitor cross-segment traffic
tcpdump -i any -n net 10.0.0.0/8
```

---

## 3. Cryptography & Key Management

### Encryption Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **openssl** | openssl | Cryptography toolkit | `openssl enc -aes-256-cbc -in file -out file.enc` |
| **gpg** | gnupg | Encryption/signing | `gpg --encrypt --recipient user@domain file` |
| **age** | age (manual) | Modern encryption | `age -o output.enc -R recipients.txt input` |
| **hashcat** | hashcat | Password recovery | `hashcat -m 0 hash.txt wordlist.txt` |
| **john** | john | Password cracker | `john --wordlist=rockyou.txt hash.txt` |
| **veracrypt** | veracrypt | Disk encryption | `veracrypt --create volume.hc` |
| **cryptsetup** | cryptsetup | LUKS encryption | `cryptsetup luksFormat /dev/sdX` |
| **ccrypt** | ccrypt | File encryption | `ccrypt file.txt` |

### OpenSSL Common Commands
```bash
# Generate RSA key
openssl genrsa -out private.key 4096

# Extract public key
openssl rsa -in private.key -pubout -out public.key

# Generate CSR
openssl req -new -key private.key -out request.csr

# Generate self-signed cert
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365

# Verify certificate
openssl x509 -in cert.pem -text -noout

# Check SSL/TLS connection
openssl s_client -connect target.com:443

# Encrypt file
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc

# Decrypt file
openssl enc -aes-256-cbc -d -in file.enc -out file.txt
```

### GPG Common Commands
```bash
# Generate key
gpg --full-generate-key

# List keys
gpg --list-keys

# Export public key
gpg --armor --export user@domain > public.key

# Encrypt file
gpg --encrypt --recipient user@domain --output file.gpg file

# Decrypt file
gpg --decrypt --output file file.gpg

# Sign file
gpg --armor --detach-sign file

# Verify signature
gpg --verify file.asc file
```

---

## 4. Container Security

### Container Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **trivy** | trivy | Container scanner | `trivy image nginx:latest` |
| **clair** | clair | Container scanning | `clair-scanner alpine:latest` |
| **docker-bench** | docker-bench-security | Docker security | `./docker-bench-security.sh` |
| **kube-bench** | kube-bench (manual) | K8s benchmarking | `kube-bench` |
| **kubesec** | kubesec (manual) | K8s security | `kubesec scan pod.yaml` |
| **falco** | falco | Runtime security | `falco --config falco_rules.yaml` |
| **grype** | grype | Vulnerability scanner | `grype nginx:latest` |
| **syft** | syft | SBOM generation | `syft nginx:latest` |

### Trivy Usage Examples
```bash
# Scan container image
trivy image nginx:latest

# Scan with specific severity
trivy image --severity HIGH,CRITICAL nginx:latest

# Generate report
trivy image -f html -o report.html nginx:latest

# Scan filesystem
trivy fs /path/to/project

# Scan Kubernetes config
trivy k8s --report summary cluster

# Scan SBOM
trivy sbom --input sbom.json
```

### Docker Bench Security Checks
```bash
# Run full benchmark
./docker-bench-security.sh

# Check specific tests
./docker-bench-security.sh -c docker_bench

# List all checks
./docker-bench-security.sh -l

# Output to file
./docker-bench-security.sh -o output.log
```

---

## 5. Cloud Security

### Cloud Security Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **prowler** | prowler (pip) | AWS security | `prowler -M csv` |
| **scout-suite** | scout-suite (pip) | Multi-cloud audit | `python3 scout.py aws` |
| **pacu** | pacu (pip) | AWS exploitation | `pacu` (interactive) |
| **cloudsploit** | cloudsploit (manual) | Cloud security | Node.js application |
| **steampipe** | steampipe (manual) | Cloud querying | `steampipe query` |
| **cloud-custodian** | cloud-custodian (pip) | Cloud policy | `custodian run policy.yml` |

### Prowler (AWS) Examples
```bash
# Run all checks
prowler -M csv

# Run specific check
prowler -c check11

# Run with specific profile
prowler -p profile_name

# Generate compliance report
prowler -M html,json -c check11,check12

# Check CIS benchmark
prowler -c cis
```

### Scout Suite Examples
```bash
# AWS audit
python3 scout.py aws

# Azure audit
python3 scout.py azure

# GCP audit
python3 scout.py gcp

# Generate report
python3 scout.py aws --report-name my-audit
```

---

## 6. Secrets Management

### Secrets Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **sops** | sops (manual) | Secrets encryption | `sops encrypt.yaml > encrypt.enc.yaml` |
| **vault** | vault (manual) | Secrets management | `vault kv put secret/key value=secret` |
| **git-secrets** | git-secrets (manual) | Git secret scanning | `git-secrets --scan` |
| **trufflehog** | trufflehog (pip) | Secret discovery | `trufflehog git https://github.com/user/repo` |
| **gitleaks** | gitleaks (go) | Git secret scanning | `gitleaks detect --source .` |
| **detect-secrets** | detect-secrets (pip) | Secret detection | `detect-secrets scan > .secrets.baseline` |

### SOPS Usage Examples
```bash
# Encrypt file
sops --encrypt input.yaml > output.enc.yaml

# Decrypt file
sops --decrypt output.enc.yaml > input.yaml

# Edit encrypted file
sops output.enc.yaml

# Encrypt with age key
sops --encrypt --age age1publickey input.yaml

# Encrypt specific values
sops --encrypt --encrypted-regex '^(password|secret|key)$' config.yaml
```

### Gitleaks Examples
```bash
# Scan current directory
gitleaks detect --source .

# Scan git repository
gitleaks detect --source . --verbose

# Generate report
gitleaks detect --source . --report-path report.json

# Scan with custom config
gitleaks detect --source . --config custom.toml
```

---

## 7. Configuration Management

### IaC Security

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **checkov** | checkov (pip) | IaC scanning | `checkov -f terraform.tf` |
| **terrascan** | terrascan (go) | IaC scanner | `terrascan scan -i terraform` |
| **tfsec** | tfsec (go) | Terraform scanner | `tfsec .` |
| **infracost** | infracost (manual) | Cost + security | `infracost breakdown --path .` |
| **ansible-lint** | ansible-lint | Ansible linting | `ansible-lint playbook.yml` |
| **yamllint** | yamllint | YAML validation | `yamllint config.yaml` |

### Checkov Examples
```bash
# Scan Terraform
checkov -f main.tf

# Scan directory
checkov -d ./terraform

# Generate report
checkov -d . --output json --output-filepath report.json

# Check specific framework
checkov -d . --framework terraform

# Skip specific checks
checkov -d . --skip-check CKV_AWS_20
```

---

## 8. Security Architecture

### Architecture Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **draw.io** | draw.io (web) | Diagramming | Web/desktop application |
| **plantuml** | plantuml | UML diagrams | `plantuml diagram.puml` |
| **graphviz** | graphviz | Graph visualization | `dot -Tpng graph.dot -o output.png` |
| **threat-dragon** | threat-dragon (manual) | Threat modeling | Desktop/web application |
| **owasp-threat-dragon** | owasp-threat-dragon | Threat modeling | Web application |

### Threat Modeling Workflow
```
1. Define system boundaries
2. Create data flow diagram (DFD)
3. Identify trust boundaries
4. List threats (STRIDE)
5. Rate threats (DREAD)
6. Define mitigations
7. Document in threat-dragon
```

---

## Top 10 Security Engineer Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Lynis** | Auditing | Comprehensive security auditing |
| 2 | **OpenSCAP** | Compliance | Standard compliance scanning |
| 3 | **Trivy** | Container | Fast container/IaC scanning |
| 4 | **OpenSSL** | Crypto | Essential cryptography toolkit |
| 5 | **Terraform** | IaC | Infrastructure as code |
| 6 | **Checkov** | IaC Security | IaC security scanning |
| 7 | **Prowler** | Cloud | AWS security auditing |
| 8 | **Vault** | Secrets | Secrets management |
| 9 | **Falco** | Runtime | Container runtime security |
| 10 | **Gitleaks** | Secrets | Git secret scanning |

---

## Quick Reference Commands

### System Hardening
```bash
# Run security audit
lynis audit system

# Check CIS compliance
oscap xccdf eval --profile cis sds.xml

# Review firewall rules
iptables -L -n -v --line-numbers

# Check open ports
ss -tulpn

# Review users
cat /etc/passwd | grep -v nologin
```

### Certificate Management
```bash
# Generate CSR
openssl req -new -key private.key -out request.csr

# Generate self-signed cert
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365

# Verify cert chain
openssl verify -CAfile ca.pem cert.pem

# Check cert details
openssl x509 -in cert.pem -text -noout
```

### Container Security
```bash
# Scan image
trivy image nginx:latest

# Run Docker bench
./docker-bench-security.sh

# Check running containers
docker inspect --format='{{.Config.User}}' $(docker ps -q)

# Review network
docker network ls
docker network inspect bridge
```

### Cloud Security
```bash
# AWS security audit
prowler -M csv

# Multi-cloud audit
scout.py aws
scout.py azure
scout.py gcp

# Scan Terraform
checkov -d ./terraform
tfsec .
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Auditing** | Lynis, Tiger, OpenSCAP |
| **Network** | Nmap, Tcpdump, Wireshark, Iptables |
| **Crypto** | OpenSSL, GPG, Hashcat, John |
| **Container** | Trivy, Docker Bench |
| **Cloud** | Prowler, ScoutSuite, Pacu |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Vault** | apt or binary | Secrets management |
| **SOPS** | apt or binary | Secrets encryption |
| **Checkov** | pip | IaC scanning |
| **Terrascan** | Download binary | IaC scanning |
| **Falco** | apt or Helm | Runtime security |
| **Threat Dragon** | Download/AppImage | Threat modeling |
| **CIS-CAT** | Download from CIS | Benchmarking tool |
| **Steampipe** | apt or binary | Cloud querying |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Red Team** | Receive findings for hardening |
| **Blue Team** | Implement security controls |
| **Purple Team** | Validate control efficacy |
| **Compliance Auditor** | Provide compliance evidence |
| **Code Reviewer** | Review IaC security |
| **Incident Response** | Implement containment measures |

---

## Security Engineering Checklist

### System Hardening
- [ ] Run Lynis audit
- [ ] Apply CIS benchmarks
- [ ] Remove unnecessary services
- [ ] Configure firewall rules
- [ ] Enable logging/monitoring
- [ ] Configure automatic updates
- [ ] Implement file integrity monitoring

### Network Security
- [ ] Segment networks
- [ ] Configure IDS/IPS
- [ ] Implement Zero Trust
- [ ] Enable TLS everywhere
- [ ] Configure DNS security
- [ ] Deploy network monitoring

### Container Security
- [ ] Scan images for vulnerabilities
- [ ] Run Docker Bench
- [ ] Implement runtime security (Falco)
- [ ] Configure network policies
- [ ] Enable resource limits
- [ ] Use non-root users

### Cloud Security
- [ ] Run Prowler/ScoutSuite
- [ ] Enable CloudTrail/Activity Logs
- [ ] Configure IAM least privilege
- [ ] Enable encryption at rest
- [ ] Implement VPC/network segmentation
- [ ] Configure security groups/NSGs

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
