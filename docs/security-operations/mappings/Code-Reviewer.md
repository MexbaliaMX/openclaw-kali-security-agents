# Code Reviewer - Kali Linux Tool Mapping

**Agent:** 👁️ Code Reviewer  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 35  
**Status:** Complete

---

## Overview

**Mission:** Security-focused code review including SAST, SCA, secret detection, and IaC security scanning.

**Primary Use Cases:**
- Static Application Security Testing (SAST)
- Software Composition Analysis (SCA)
- Secret detection in code repositories
- Infrastructure as Code (IaC) security
- Container security scanning
- Code quality and security metrics

---

## 1. Static Application Security Testing (SAST)

### Multi-Language SAST

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **semgrep** | semgrep | Static analysis | `semgrep --config auto/ .` |
| **sonarqube** | sonarqube (manual) | Code quality/security | Web interface |
| **bandit** | bandit (pip) | Python security | `bandit -r ./project` |
| **eslint** | eslint (npm) | JavaScript linting | `eslint --ext .js,.jsx .` |
| **gosec** | gosec (go) | Go security | `gosec ./...` |
| **brakeman** | brakeman (gem) | Ruby security | `brakeman ./rails-app` |
| **phpcs** | phpcs (composer) | PHP security | `phpcs --standard=WordPress` |

### Semgrep Usage Examples
```bash
# Auto-detect language and run community rules
semgrep --config auto/ .

# Run specific language rules
semgrep --config p/python .

# Run OWASP Top 10 rules
semgrep --config p/owasp-top-10 .

# Generate report
semgrep --config auto/ --json --output report.json .

# Custom rule
semgrep --config my_rules.yml .

# CI/CD integration
semgrep --config auto/ --error --output findings.sarif .
```

### Semgrep Custom Rule Example
```yaml
rules:
  - id: dangerous-eval
    patterns:
      - pattern: eval($USER_INPUT)
    message: "Use of eval() with user input is dangerous"
    languages: [python, javascript]
    severity: ERROR
    metadata:
      cwe: "CWE-95: Improper Neutralization of Directives in Dynamically Evaluated Code"
      owasp: "A03:2021-Injection"
```

### Bandit (Python) Examples
```bash
# Scan directory
bandit -r ./project

# Specific severity
bandit -r ./project -ll

# Generate report
bandit -r ./project -f html -o report.html

# Skip specific tests
bandit -r ./project -s B101

# Run specific tests
bandit -r ./project -t B301,B302
```

---

## 2. Software Composition Analysis (SCA)

### Dependency Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dependency-check** | dependency-check | Dependency scanner | `dependency-check.sh --scan ./lib` |
| **snyk** | snyk (npm) | Vulnerability scanner | `snyk test` |
| **trivy** | trivy | Multi-scanner | `trivy fs ./project` |
| **grype** | grype | Vulnerability scanner | `grype ./project` |
| **osv-scanner** | osv-scanner (go) | OSV scanning | `osv-scanner ./project` |
| **npm-audit** | npm (built-in) | npm audit | `npm audit` |
| **pip-audit** | pip-audit (pip) | pip audit | `pip-audit` |
| **bundler-audit** | bundler-audit (gem) | Ruby audit | `bundle audit` |

### Trivy SCA Examples
```bash
# Scan filesystem
trivy fs ./project

# Scan with specific severity
trivy fs --severity HIGH,CRITICAL ./project

# Generate report
trivy fs -f html -o report.html ./project

# Scan lock files
trivy fs package-lock.json
trivy fs requirements.txt
trivy fs Gemfile.lock

# Scan SBOM
trivy sbom --input sbom.json
```

### Snyk Usage Examples
```bash
# Test project
snyk test

# Test with remediation advice
snyk test --show-vulnerable-paths

# Monitor project
snyk monitor

# Test container
snyk test --docker nginx:latest

# Fix vulnerabilities
snyk fix
```

---

## 3. Secret Detection

### Secret Scanning Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **trufflehog** | trufflehog (pip) | Secret discovery | `trufflehog git https://github.com/user/repo` |
| **gitleaks** | gitleaks (go) | Git secret scanning | `gitleaks detect --source .` |
| **detect-secrets** | detect-secrets (pip) | Secret detection | `detect-secrets scan > .secrets.baseline` |
| **git-secrets** | git-secrets (manual) | Git pre-commit | `git-secrets --scan` |
| **talisman** | talisman (go) | Git hook | `talisman --githook pre-commit` |

### Trufflehog Examples
```bash
# Scan git repository
trufflehog git https://github.com/user/repo

# Scan local directory
trufflehog filesystem ./project

# Scan with verification
trufflehog git https://github.com/user/repo --only-verified

# Generate report
trufflehog git https://github.com/user/repo --json > findings.json

# Scan specific branch
trufflehog git https://github.com/user/repo --branch=main
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

# Pre-commit hook
gitleaks protect --source . --staged
```

### Detect-Secrets Workflow
```bash
# Initialize baseline
detect-secrets scan > .secrets.baseline

# Audit findings
detect-secrets audit .secrets.baseline

# Scan with baseline
detect-secrets scan --baseline .secrets.baseline

# CI/CD check
detect-secrets scan --baseline .secrets.baseline --fail-on-unaudited
```

---

## 4. Infrastructure as Code (IaC) Security

### Terraform Security

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **checkov** | checkov (pip) | IaC scanning | `checkov -f terraform.tf` |
| **terrascan** | terrascan (go) | IaC scanner | `terrascan scan -i terraform` |
| **tfsec** | tfsec (go) | Terraform scanner | `tfsec .` |
| **infracost** | infracost (manual) | Cost + security | `infracost breakdown --path .` |

### Checkov Examples
```bash
# Scan Terraform file
checkov -f main.tf

# Scan directory
checkov -d ./terraform

# Generate report
checkov -d . --output json --output-filepath report.json

# Check specific framework
checkov -d . --framework terraform

# Skip specific checks
checkov -d . --skip-check CKV_AWS_20

# Run with soft fail
checkov -d . --soft-fail
```

### TFSec Examples
```bash
# Scan current directory
tfsec .

# Scan specific file
tfsec main.tf

# Generate report
tfsec . -f json -o report.json

# Specific severity
tfsec . --severity HIGH

# Exclude checks
tfsec . --exclude aws-s3-enable-bucket-encryption
```

### Terrascan Examples
```bash
# Scan Terraform
terrascan scan -i terraform

# Scan Kubernetes
terrascan scan -i k8s

# Generate report
terrascan scan -i terraform -o json -f report.json

# Run with specific policy
terrascan scan -i terraform -p accuracy
```

---

## 5. Container Security

### Container Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **trivy** | trivy | Container scanner | `trivy image nginx:latest` |
| **grype** | grype | Vulnerability scanner | `grype nginx:latest` |
| **docker-bench** | docker-bench-security | Docker security | `./docker-bench-security.sh` |
| **clair** | clair | Container scanning | `clair-scanner alpine:latest` |
| **falco** | falco | Runtime security | `falco --config falco_rules.yaml` |

### Trivy Container Examples
```bash
# Scan image
trivy image nginx:latest

# Scan with severity filter
trivy image --severity HIGH,CRITICAL nginx:latest

# Generate report
trivy image -f html -o report.html nginx:latest

# Scan local Docker
trivy image --input saved-image.tar

# Scan running container
trivy image docker://container_id
```

### Docker Bench Security
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

## 6. Kubernetes Security

### K8s Security Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **kube-bench** | kube-bench (manual) | K8s benchmarking | `kube-bench` |
| **kubesec** | kubesec (manual) | K8s security | `kubesec scan pod.yaml` |
| **kube-hunter** | kube-hunter (pip) | K8s penetration | `kube-hunter --remote` |
| **datadog** | datadog (manual) | K8s monitoring | Web interface |
| **trivy** | trivy | K8s scanning | `trivy k8s --report summary` |

### Kube-Bench Examples
```bash
# Run benchmarks
kube-bench

# Run specific benchmark
kube-bench run --targets master

# Generate report
kube-bench --json > report.json
```

### Kubesec Examples
```bash
# Scan pod definition
kubesec scan pod.yaml

# Scan with score threshold
kubesec scan --score 5 pod.yaml

# HTTP API
curl -sSX POST --data-binary @pod.yaml https://v2.kubesec.io/scan
```

---

## 7. API Security

### API Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **postman** | postman (manual) | API testing | GUI application |
| **insomnia** | insomnia (manual) | API client | GUI application |
| **burpsuite** | burpsuite | API security | GUI application |
| **42crunch** | 42crunch (manual) | API security | Web platform |
| **noname** | noname (manual) | API security | Web platform |

---

## Top 10 Code Reviewer Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Semgrep** | SAST | Fast, customizable static analysis |
| 2 | **Trivy** | Multi | Container + filesystem + IaC |
| 3 | **Gitleaks** | Secrets | Git secret scanning |
| 4 | **Checkov** | IaC | Terraform/K8s security |
| 5 | **Bandit** | SAST | Python security scanning |
| 6 | **SonarQube** | SAST | Comprehensive code quality |
| 7 | **Snyk** | SCA | Dependency vulnerability scanning |
| 8 | **TFSec** | IaC | Terraform security |
| 9 | **Docker Bench** | Container | Docker security auditing |
| 10 | **Kube-Bench** | K8s | Kubernetes benchmarking |

---

## Quick Reference Commands

### SAST Workflow
```bash
# Run Semgrep
semgrep --config auto/ --json --output semgrep.json .

# Run language-specific tools
bandit -r ./python-project -f json -o bandit.json
gosec ./... -fmt json -out gosec.json
brakeman ./rails-app -o brakeman.json

# Aggregate results
# Import to SIEM or security dashboard
```

### SCA Workflow
```bash
# Run Trivy
trivy fs --format json --output trivy.json .

# Run Snyk
snyk test --json > snyk.json

# Run npm/pip audit
npm audit --json > npm-audit.json
pip-audit --format json > pip-audit.json
```

### Secret Detection Workflow
```bash
# Initialize and scan
gitleaks detect --source . --report-path gitleaks.json
trufflehog filesystem ./project --json > trufflehog.json

# Pre-commit hook
gitleaks protect --source . --staged
```

### IaC Security Workflow
```bash
# Terraform
checkov -d ./terraform -o json -o checkov.json
tfsec . -f json -o tfsec.json

# Kubernetes
kubesec scan pod.yaml > kubesec.json
kube-bench --json > kube-bench.json
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **SAST** | Bandit, Semgrep |
| **SCA** | Trivy, dependency-check |
| **Secrets** | Trufflehog, Gitleaks |
| **IaC** | Checkov, TFSec |
| **Container** | Trivy, Docker Bench |
| **K8s** | Kube-Bench |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **SonarQube** | Docker or download | Full platform |
| **Snyk** | npm install -g | Requires account |
| **Postman** | Download/Snap | API testing |
| **Burp Suite Pro** | Download from PortSwigger | Commercial |
| **42Crunch** | Web platform | API security |
| **Noname** | Web platform | API security |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Security Engineer** | Review IaC, implement fixes |
| **Web Pentesting** | Validate findings, share results |
| **MCP Builder** | Secure AI tool development |
| **Red Team** | Receive exploitation findings |
| **Compliance Auditor** | Provide code security evidence |
| **DevOps** | CI/CD integration |

---

## CI/CD Integration Examples

### GitHub Actions
```yaml
name: Security Scan
on: [push, pull_request]
jobs:
  semgrep:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: returntocorp/semgrep-action@v1
        with:
          config: auto
  
  trivy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          format: 'sarif'
          output: 'trivy-results.sarif'
  
  gitleaks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: gitleaks/gitleaks-action@v2
```

### GitLab CI
```yaml
security-scan:
  stage: test
  script:
    - semgrep --config auto/ --json --output semgrep.json .
    - trivy fs --format json --output trivy.json .
    - gitleaks detect --source . --report-path gitleaks.json
  artifacts:
    reports:
      sast: semgrep.json
      dependency_scanning: trivy.json
```

---

## Code Review Checklist

### SAST
- [ ] Run Semgrep with auto config
- [ ] Run language-specific tools
- [ ] Review HIGH/CRITICAL findings
- [ ] Fix or document false positives

### SCA
- [ ] Scan dependencies
- [ ] Update vulnerable packages
- [ ] Review transitive dependencies
- [ ] Enable automated updates

### Secrets
- [ ] Scan repository history
- [ ] Rotate any found secrets
- [ ] Add pre-commit hooks
- [ ] Update .gitignore

### IaC
- [ ] Scan Terraform/K8s configs
- [ ] Fix misconfigurations
- [ ] Enable policy as code
- [ ] Document exceptions

### Container
- [ ] Scan base images
- [ ] Update to latest versions
- [ ] Run Docker Bench
- [ ] Implement runtime security

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
