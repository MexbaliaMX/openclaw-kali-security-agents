# Compliance Auditor - Kali Linux Tool Mapping

**Agent:** 📋 Compliance Auditor  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 28  
**Status:** Complete

---

## Overview

**Mission:** Compliance assessments, audit readiness, gap analysis, and regulatory mapping across multiple frameworks.

**Primary Use Cases:**
- Compliance scanning (CIS, NIST, ISO, SOC 2)
- Gap assessments
- Audit evidence collection
- Regulatory mapping
- Policy enforcement
- Compliance reporting

---

## 1. Compliance Scanning

### System Compliance

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **openscap** | openscap-scanner | Compliance scanning | `oscap xccdf eval --profile cis sds.xml` |
| **cis-cat** | cis-cat (manual) | CIS benchmarking | Java application |
| **lynis** | lynis | Security auditing | `lynis audit system` |
| **tiger** | tiger | Security checker | `tiger` |
| **harden** | harden (manual) | Hardening checker | `harden` |

### OpenSCAP Examples
```bash
# List available profiles
oscap info /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Run CIS benchmark
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results cis-results.xml \
  --report cis-report.html \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Run STIG benchmark
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_stig \
  --results stig-results.xml \
  --report stig-report.html \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Run PCI-DSS benchmark
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_pci-dss \
  --results pci-results.xml \
  --report pci-report.html \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Remediate failures
oscap xccdf eval \
  --profile cis \
  --remediate \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml
```

### Lynis Compliance Examples
```bash
# Full system audit
lynis audit system

# Generate report
lynis audit system --report-file /tmp/lynis-report.txt

# Check specific category
lynis audit system remote
lynis audit system malware

# View recommendations
lynis show recommendations
```

---

## 2. Framework Mapping

### Compliance Frameworks

| Framework | Tool Support | Coverage |
|-----------|--------------|----------|
| **CIS Benchmarks** | OpenSCAP, CIS-CAT | Full |
| **NIST CSF** | OpenSCAP, custom | Full |
| **NIST 800-53** | OpenSCAP, custom | Full |
| **ISO 27001** | Custom mapping | Full |
| **SOC 2** | Custom mapping | Full |
| **PCI-DSS** | OpenSCAP | Partial |
| **HIPAA** | Custom mapping | Full |
| **GDPR** | Custom mapping | Full |
| **HITRUST** | Custom mapping | Full |

### NIST CSF Mapping Workflow
```
1. Identify (ID)
   □ Asset inventory
   □ Risk assessment
   □ Governance

2. Protect (PR)
   □ Access control
   □ Awareness training
   □ Data security
   □ Protective technology

3. Detect (DE)
   □ Anomaly detection
   □ Continuous monitoring
   □ Detection processes

4. Respond (RS)
   □ Response planning
   □ Communications
   □ Analysis
   □ Mitigation

5. Recover (RC)
   □ Recovery planning
   □ Improvements
   □ Communications
```

### OpenSCAP NIST Mapping
```bash
# NIST 800-53 profile
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_nist_soc2 \
  --results nist-results.xml \
  --report nist-report.html \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# NIST CSF profile
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results csf-results.xml \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml
```

---

## 3. Audit Evidence Collection

### Evidence Collection Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dradis** | dradis (manual) | Evidence collection | Web interface |
| **serpico** | serpico (manual) | Report generation | Web interface |
| **magictree** | magictree | Evidence management | `magictree` (GUI) |
| **keepnote** | keepnote | Note taking | GUI application |
| **cherrytree** | cherrytree | Hierarchical notes | `cherrytree` (GUI) |

### Evidence Collection Checklist
```
Access Control:
  □ User account listing
  □ Group membership
  □ Privileged access review
  □ MFA configuration
  □ Password policies

System Configuration:
  □ Firewall rules
  □ Service inventory
  □ Patch levels
  □ Hardening status

Monitoring:
  □ Log configuration
  □ SIEM integration
  □ Alert definitions
  □ Retention policies

Incident Response:
  □ IR plan documentation
  □ Contact lists
  □ Playbooks
  □ Test results
```

### Automated Evidence Collection
```bash
#!/bin/bash
# Evidence collection script

EVIDENCE_DIR="./evidence_$(date +%Y%m%d)"
mkdir -p $EVIDENCE_DIR

# User accounts
cat /etc/passwd > $EVIDENCE_DIR/users.txt
cat /etc/group > $EVIDENCE_DIR/groups.txt
lastlog > $EVIDENCE_DIR/lastlog.txt

# Network configuration
ip addr > $EVIDENCE_DIR/network.txt
iptables -L -n -v > $EVIDENCE_DIR/firewall.txt
ss -tulpn > $EVIDENCE_DIR/listening.txt

# Services
systemctl list-units --type=service > $EVIDENCE_DIR/services.txt

# Installed packages
dpkg -l > $EVIDENCE_DIR/packages.txt

# Logs
journalctl --since "30 days ago" > $EVIDENCE_DIR/journal.log

# Security audit
lynis audit system > $EVIDENCE_DIR/lynis.txt

# Create archive
tar -czf evidence_$(date +%Y%m%d).tar.gz $EVIDENCE_DIR

# Generate hash
sha256sum evidence_$(date +%Y%m%d).tar.gz > evidence_$(date +%Y%m%d).sha256
```

---

## 4. Policy Enforcement

### Policy as Code

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **opa** | opa (manual) | Policy engine | `opa eval -i data.json policy.rego` |
| **kyverno** | kyverno (manual) | K8s policy | `kyverno apply policy.yaml` |
| **sentinel** | sentinel (manual) | HashiCorp policy | `sentinel apply` |
| **cloud-custodian** | cloud-custodian (pip) | Cloud policy | `custodian run policy.yml` |

### OPA Policy Example
```rego
package security

# Require MFA for admin users
deny[msg] {
    input.user.role == "admin"
    not input.user.mfa_enabled
    msg := "Admin users must have MFA enabled"
}

# Require encryption for sensitive data
deny[msg] {
    input.resource.type == "database"
    not input.resource.encrypted
    msg := "Databases must be encrypted"
}

# Require private subnets for application servers
deny[msg] {
    input.resource.type == "ec2_instance"
    input.resource.subnet_type == "public"
    msg := "Application servers must be in private subnets"
}
```

### Cloud Custodian Examples
```yaml
# policy.yml - Require encryption for S3 buckets
policies:
  - name: s3-require-encryption
    resource: aws.s3
    filters:
      - type: encryption
        enabled: false
    actions:
      - type: mark-for-remediation
        days: 7
      - type: notify
        template: default
        to:
          - security@company.com
        transport:
          type: sqs
          queue: security-notifications
```

---

## 5. Vulnerability Compliance

### Vulnerability Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **openvas** | openvas | Vulnerability scanner | `gvm-start` (GUI) |
| **nessus** | nessus (manual) | Vulnerability scanner | Web interface |
| **qualys** | qualys (manual) | Cloud scanner | Web platform |
| **rapid7** | rapid7 (manual) | InsightVM | Web platform |
| **trivy** | trivy | Container/filesystem | `trivy fs ./project` |

### Compliance Reporting
```bash
# Generate CVSS report
openvas-cli --xml < report-filter.xml

# Export compliance data
# Web interface for Nessus/Qualys/Rapid7

# Aggregate vulnerability data
# Import to GRC platform
```

---

## 6. Cloud Compliance

### Cloud Compliance Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **prowler** | prowler (pip) | AWS compliance | `prowler -M csv` |
| **scout-suite** | scout-suite (pip) | Multi-cloud audit | `python3 scout.py aws` |
| **cloudsploit** | cloudsploit (manual) | Cloud security | Node.js application |
| **steampipe** | steampipe (manual) | Cloud querying | `steampipe query` |
| **cloud-custodian** | cloud-custodian (pip) | Cloud policy | `custodian run policy.yml` |

### Prowler Compliance Examples
```bash
# Run CIS benchmark
prowler -c cis

# Run all checks
prowler -M csv

# Generate compliance report
prowler -M html,json -c cis

# Specific AWS service
prowler -c s3,ec2,iam

# With specific profile
prowler -p production_profile -M csv
```

---

## 7. Reporting & Documentation

### Report Generation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dradis** | dradis (manual) | Collaboration/reporting | Web interface |
| **serpico** | serpico (manual) | Report generation | Web interface |
| **pwndoc** | pwndoc (manual) | Pentest documentation | Web interface |
| **reportingtool** | reportingtool (manual) | Report generation | Web interface |

### Report Templates

| Section | Content |
|---------|---------|
| **Executive Summary** | High-level findings, risk rating |
| **Scope** | Systems assessed, timeframe |
| **Methodology** | Tools used, standards followed |
| **Findings** | Detailed vulnerabilities/gaps |
| **Compliance Status** | Framework-by-framework status |
| **Recommendations** | Prioritized remediation steps |
| **Appendix** | Evidence, raw data, references |

---

## Top 10 Compliance Auditor Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **OpenSCAP** | Compliance | Standard compliance scanning |
| 2 | **Lynis** | Auditing | Comprehensive security audit |
| 3 | **CIS-CAT** | Benchmarking | Official CIS benchmarking |
| 4 | **Prowler** | Cloud | AWS compliance auditing |
| 5 | **Dradis** | Reporting | Evidence collection/reporting |
| 6 | **ScoutSuite** | Cloud | Multi-cloud auditing |
| 7 | **OPA** | Policy | Policy as code engine |
| 8 | **Cloud Custodian** | Cloud Policy | Cloud governance |
| 9 | **Trivy** | Vulnerability | Container/filesystem scanning |
| 10 | **Steampipe** | Cloud Query | Cloud compliance querying |

---

## Quick Reference Commands

### CIS Benchmark Assessment
```bash
# Run CIS scan
oscap xccdf eval \
  --profile cis \
  --results cis-results.xml \
  --report cis-report.html \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# View results
oscap xccdf generate-report cis-results.xml
```

### NIST CSF Mapping
```bash
# Run NIST 800-53 scan
oscap xccdf eval \
  --profile nist_soc2 \
  --results nist-results.xml \
  /usr/share/xml/scap/ssg/content/ssg-debian11-ds.xml

# Map to CSF functions
# Manual mapping in spreadsheet or GRC tool
```

### Cloud Compliance
```bash
# AWS CIS benchmark
prowler -c cis -M csv

# Multi-cloud audit
python3 scout.py aws
python3 scout.py azure
python3 scout.py gcp

# Generate reports
# Web interface or API
```

### Evidence Collection
```bash
# Collect system evidence
./collect_evidence.sh

# Generate hash
sha256sum evidence.tar.gz > evidence.sha256

# Document chain of custody
# Add to evidence log
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Compliance** | OpenSCAP, Lynis, Tiger |
| **Cloud** | Prowler, ScoutSuite |
| **Vulnerability** | OpenVAS, Trivy |
| **Reporting** | Dradis (manual) |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **CIS-CAT** | Download from CIS | Official benchmarking |
| **Nessus** | Download from Tenable | Free for home use |
| **Qualys** | Web platform | Commercial |
| **Rapid7** | Web platform | Commercial |
| **OPA** | Download binary | Policy engine |
| **Cloud Custodian** | pip | Cloud policy |
| **Steampipe** | apt or binary | Cloud querying |
| **Serpico** | GitHub | Report generation |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Security Engineer** | Implement compliance controls |
| **Red Team** | Validate control effectiveness |
| **Blue Team** | Operational compliance evidence |
| **Purple Team** | Coverage validation |
| **Code Reviewer** | Code compliance (IaC, secrets) |
| **Incident Response** | Incident compliance reporting |

---

## Compliance Assessment Workflow

```
Phase 1 - Preparation:
  □ Define scope and frameworks
  □ Gather system access
  □ Prepare evidence collection tools

Phase 2 - Scanning:
  □ Run OpenSCAP scans
  □ Run Lynis audit
  □ Run cloud compliance tools
  □ Collect manual evidence

Phase 3 - Analysis:
  □ Review scan results
  □ Identify gaps
  □ Map to frameworks
  □ Calculate compliance scores

Phase 4 - Reporting:
  □ Generate executive report
  □ Create technical findings
  □ Document evidence
  □ Provide recommendations

Phase 5 - Remediation:
  □ Prioritize gaps
  □ Assign remediation owners
  □ Track progress
  □ Re-test after fixes
```

---

## Compliance Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **CIS Compliance Score** | >90% | OpenSCAP results |
| **Critical Findings** | 0 | Vulnerability scans |
| **Policy Violations** | <5% | Policy engine results |
| **Evidence Completeness** | 100% | Audit checklist |
| **Remediation Rate** | >95% within SLA | Tracking system |
| **Framework Coverage** | All applicable | GRC platform |

---

## Framework Crosswalk

| Control | CIS | NIST 800-53 | ISO 27001 | SOC 2 |
|---------|-----|-------------|-----------|-------|
| Access Control | 5.x | AC family | A.9 | CC6 |
| Audit Logging | 4.x | AU family | A.12 | CC7 |
| Encryption | 3.x | SC family | A.10 | CC6 |
| Patch Management | 2.x | SI family | A.12 | CC3 |
| Incident Response | 16.x | IR family | A.16 | CC7 |
| Backup | 2.x | CP family | A.12 | CC7 |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
