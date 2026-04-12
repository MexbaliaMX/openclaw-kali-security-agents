# Purple Team Integrator - Kali Linux Tool Mapping

**Agent:** 🟣 Purple Team Integrator  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 48  
**Status:** Complete

---

## Overview

**Mission:** Maximize security ROI through Red+Blue collaboration and continuous validation.

**Primary Use Cases:**
- Attack simulation and detection validation
- MITRE ATT&CK coverage mapping
- Security control efficacy testing
- Detection engineering and tuning
- Security maturity assessments

**Core Functions:**
1. **Enable** - Facilitate Red↔Blue collaboration
2. **Test** - Validate detections against real attacks
3. **Measure** - Track coverage and efficacy
4. **Improve** - Drive continuous security improvement

---

## 1. Attack Simulation

### Automated Attack Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **caldera** | caldera (manual) | Adversary emulation | `docker run -p 8888:8888 mitre/caldera` |
| **atomic-red-team** | atomic-red-team (manual) | Test cases | `Invoke-AtomicTest T1003.001` |
| **mitre-attack** | mitre-attack (web) | Framework reference | https://attack.mitre.org |
| **redcanary** | redcanary (web) | Threat reports | https://redcanary.com/threat-detection-report |

### CALDERA Usage Examples
```bash
# Start CALDERA server
docker run -p 8888:8888 mitre/caldera

# Access web interface
# http://localhost:8888

# API interaction
curl -X POST http://localhost:8888/api/v2/abilities \
  -H "Authorization: Bearer TOKEN" \
  -d '{"name": "test_ability", "tactic": "credential_access"}'
```

### Atomic Red Team Examples
```powershell
# Import Atomic Red Team module
Import-Module "C:\AtomicRedTeam\invoke-atomicredteam\Invoke-AtomicRedTeam.psd1" -Force

# Run specific test
Invoke-AtomicTest T1003.001 -GetSamplePayload

# Execute test
Invoke-AtomicTest T1003.001 -PathToAtomicsFolder "C:\AtomicRedTeam\atomics"

# Run multiple tests
Invoke-AtomicTest T1003.001, T1003.002, T1003.003 -PathToAtomicsFolder "C:\AtomicRedTeam\atomics"

# Cleanup after test
Invoke-AtomicTest T1003.001 -Cleanup
```

### Simulation Frameworks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **metasploit** | metasploit-framework | Exploitation framework | `msfconsole` |
| **sliver** | sliver (manual) | C2 framework | `sliver-server` |
| **empire** | empire (manual) | Post-exploitation | `./empire` |
| **covenant** | covenant (manual) | .NET C2 | Web interface |
| **attack-range** | attack-range (manual) | Test environment | `python3 attack_range.py simulate` |

---

## 2. Detection Testing & Validation

### Detection Rule Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **sigma** | sigma (pip) | Detection rules | `sigma convert -t splunk rule.yml` |
| **detectionlab** | detectionlab (manual) | Test environment | Vagrant/terraform setup |
| **wazuh** | wazuh | SIEM/HIDS | Web interface |
| **osquery** | osquery | System querying | `osqueryi "SELECT * FROM processes"` |
| **sysmon** | sysmon (Windows) | System monitoring | `Sysmon64.exe -i config.xml` |

### Sigma Rule Examples
```yaml
title: Suspicious PowerShell Encoded Command
id: 12345678-1234-1234-1234-123456789012
status: experimental
description: Detects PowerShell with encoded commands
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        Image|endswith: '\powershell.exe'
        CommandLine|contains:
            - '-enc'
            - '-encodedcommand'
            - '-e '
    condition: selection
level: high
tags:
    - mitre.attack.T1059.001
    - mitre.attack.T1140
```

### Sigma Conversion Commands
```bash
# Convert to Splunk
sigma convert -t splunk windows_powershell_encoded.yml

# Convert to Elastic
sigma convert -t elasticsearch windows_powershell_encoded.yml

# Convert to Defender
sigma convert -t defender windows_powershell_encoded.yml

# Convert to multiple formats
sigma convert -t splunk,elasticsearch,defender rule.yml
```

### Detection Lab Setup
```bash
# Clone Detection Lab
git clone https://github.com/clong/DetectionLab.git
cd DetectionLab/Vagrant

# Start lab
vagrant up

# Access VMs
# DC: <lab-dc-ip>
# WORKSTATION: <lab-workstation-ip>
```

---

## 3. Coverage Mapping

### MITRE ATT&CK Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **attack-navigator** | attack-navigator (web) | Coverage visualization | Web-based tool |
| **mitre-attack-framework** | mitre-attack (pip) | API access | `pip install mitre-attack-framework` |
| **attack-workbench** | attack-workbench (manual) | Content management | Web interface |
| **car** | car (web) | Analytics repository | https://car.mitre.org |

### ATT&CK Navigator Usage
```
1. Download NAVIGATOR from GitHub
2. Open in browser
3. Load layer template
4. Color techniques by coverage:
   - Green: Detected
   - Yellow: Partially detected
   - Red: Not detected
   - Gray: Not applicable
5. Export layer for reporting
```

### Coverage Assessment Workflow
```
Phase 1 - Baseline:
  □ Map existing detections to MITRE ATT&CK
  □ Identify coverage gaps
  □ Prioritize by risk

Phase 2 - Testing:
  □ Run Atomic Red Team tests
  □ Validate detection firing
  □ Document false negatives

Phase 3 - Improvement:
  □ Create new detection rules
  □ Tune existing rules
  □ Re-test and validate

Phase 4 - Reporting:
  □ Generate coverage heatmap
  □ Document improvements
  □ Update maturity score
```

---

## 4. Security Control Validation

### Control Testing Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **mitre-evaluate** | mitre-evaluate (manual) | Control assessment | Web interface |
| **cis-benchmarks** | cis-benchmarks (manual) | Hardening standards | PDF/automated tools |
| **scap** | openscap | Security content | `oscap xccdf eval profile.xml` |
| **inspec** | inspec (manual) | Compliance testing | `inspec exec profile.rb` |

### Control Efficacy Testing
```bash
# Test EDR detection
# 1. Run known malware sample (in sandbox)
# 2. Verify alert generation
# 3. Measure detection time
# 4. Document response actions

# Test SIEM correlation
# 1. Generate test events
# 2. Verify correlation rule firing
# 3. Check alert quality
# 4. Validate escalation

# Test network segmentation
# 1. Attempt lateral movement
# 2. Verify traffic blocked
# 3. Document any bypasses
```

---

## 5. Metrics & Dashboards

### Visualization Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **grafana** | grafana (manual) | Dashboards | Web interface (3000) |
| **kibana** | kibana | ES visualization | Web interface (5601) |
| **plotly** | plotly (pip) | Data visualization | Python library |
| **matplotlib** | matplotlib (pip) | Plotting | Python library |

### Dashboard Metrics to Track

| Metric | Description | Target |
|--------|-------------|--------|
| **ATT&CK Coverage %** | Techniques with detections | >80% |
| **Detection Accuracy** | True positives / total alerts | >90% |
| **False Positive Rate** | False positives / total alerts | <10% |
| **MTTD** | Mean time to detect | <1 hour |
| **MTTR** | Mean time to respond | <4 hours |
| **Test Pass Rate** | Successful detection tests | >95% |
| **Coverage by Tactic** | Per-tactic coverage % | Varies |

### Grafana Dashboard Example
```json
{
  "dashboard": {
    "title": "Purple Team Metrics",
    "panels": [
      {
        "title": "MITRE ATT&CK Coverage",
        "type": "gauge",
        "targets": [{"expr": "attack_coverage_percent"}]
      },
      {
        "title": "Detection Tests (24h)",
        "type": "stat",
        "targets": [{"expr": "detection_tests_total"}]
      },
      {
        "title": "False Positive Rate",
        "type": "graph",
        "targets": [{"expr": "false_positive_rate"}]
      }
    ]
  }
}
```

---

## 6. Automation & Orchestration

### SOAR & Automation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **n8n** | n8n (manual) | Workflow automation | Web interface |
| **node-red** | node-red | Flow-based programming | Web interface |
| **stackstorm** | stackstorm (manual) | Event-driven automation | Web interface |
| **cortex** | cortex (manual) | Analysis engine | Web interface |
| **thehive** | thehive (manual) | Case management | Web interface |

### Automation Examples
```yaml
# n8n workflow: Detection Test Triggered
trigger: atomic_test_executed
actions:
  - check_detection_fired:
      tool: siem
      query: detection_rule_id
  - if_not_detected:
      - create_ticket: thehive
      - notify_team: slack
      - schedule_retest: 24h
  - if_detected:
      - log_result: database
      - update_coverage: navigator
      - close_ticket: thehive
```

### API Integration Examples
```python
# Check if detection fired (Elasticsearch)
import requests

def check_detection(rule_id, timeframe="1h"):
    response = requests.get(
        "http://elasticsearch:9200/logs-*/_search",
        json={
            "query": {
                "bool": {
                    "filter": [
                        {"match": {"rule.id": rule_id}},
                        {"range": {"@timestamp": {"gte": f"now-{timeframe}"}}}
                    ]
                }
            }
        }
    )
    return response.json()["hits"]["total"]["value"] > 0

# Update ATT&CK Navigator layer
def update_coverage(technique_id, detected):
    layer["techniques"].append({
        "techniqueID": technique_id,
        "color": "#00ff00" if detected else "#ff0000"
    })
```

---

## 7. Collaboration Tools

### Communication & Documentation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dradis** | dradis (manual) | Collaboration platform | Web interface |
| **serpico** | serpico (manual) | Report generation | Web interface |
| **obsidian** | obsidian (manual) | Knowledge base | Desktop app |
| **logseq** | logseq (manual) | Knowledge graph | Desktop app |
| **gitbook** | gitbook (web) | Documentation | Web service |

### Shared Workspaces

| Tool | Package | Purpose |
|------|---------|---------|
| **Slack/Teams** | Web/Desktop | Real-time communication |
| **Jira** | Web service | Issue tracking |
| **Confluence** | Web service | Documentation |
| **GitHub/GitLab** | Web service | Code/rule versioning |

---

## 8. Threat Intelligence Integration

### TI Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **misp** | misp (manual) | Threat intel platform | Web interface |
| **opencti** | opencti (manual) | CTI platform | Web interface |
| **anubis** | anubis (manual) | Threat intel | Web interface |
| **taxii** | taxii (pip) | TI sharing protocol | `taxii-discovery --help` |

### IOC Integration
```python
# Pull IOCs from MISP
import pymisp

misp = PyMISP('https://misp.local', 'API_KEY')
events = misp.search(controller='events', timestamp='1d')
iocs = [attr['value'] for event in events for attr in event['Attribute']]

# Convert to detection rules
for ioc in iocs:
    create_yara_rule(ioc)
    create_sigma_rule(ioc)
```

---

## Top 10 Purple Team Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **CALDERA** | Attack Sim | Automated adversary emulation |
| 2 | **Atomic Red Team** | Testing | Standardized test cases |
| 3 | **Sigma** | Detection | Detection rule standard |
| 4 | **ATT&CK Navigator** | Coverage | Visual coverage mapping |
| 5 | **Detection Lab** | Environment | Pre-built test environment |
| 6 | **Wazuh** | SIEM | Open-source detection platform |
| 7 | **Osquery** | Visibility | System querying |
| 8 | **Grafana** | Dashboards | Metrics visualization |
| 9 | **TheHive** | Case Mgmt | Incident collaboration |
| 10 | **MISP** | Threat Intel | IOC sharing |

---

## Quick Reference Commands

### Atomic Red Team Execution
```powershell
# Import module
Import-Module "C:\AtomicRedTeam\invoke-atomicredteam\Invoke-AtomicRedTeam.psd1" -Force

# List available tests
Find-AtomicTest -SearchName "Credential"

# Run test with pre-check
Invoke-AtomicTest T1003.001 -PreCheck -PathToAtomicsFolder "C:\AtomicRedTeam\atomics"

# Execute and auto-cleanup
Invoke-AtomicTest T1003.001 -Cleanup -PathToAtomicsFolder "C:\AtomicRedTeam\atomics"

# Run full category
Invoke-AtomicCategory "Credential Access" -PathToAtomicsFolder "C:\AtomicRedTeam\atomics"
```

### Sigma Rule Pipeline
```bash
# 1. Write detection rule
cat > suspicious_powershell.yml << EOF
title: Suspicious PowerShell
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        Image|endswith: '\powershell.exe'
        CommandLine|contains: '-enc'
    condition: selection
level: high
EOF

# 2. Validate rule
sigma validate suspicious_powershell.yml

# 3. Convert to target format
sigma convert -t splunk suspicious_powershell.yml
sigma convert -t elasticsearch suspicious_powershell.yml

# 4. Deploy to SIEM
# (SIEM-specific deployment)

# 5. Test with Atomic Red Team
Invoke-AtomicTest T1059.001 -PathToAtomicsFolder "C:\AtomicRedTeam\atomics"

# 6. Verify detection
# Check SIEM for alert
```

### Coverage Assessment
```bash
# 1. Export current detections
# (SIEM-specific export)

# 2. Map to MITRE ATT&CK
# Use ATT&CK Navigator

# 3. Calculate coverage
# Count techniques with detections

# 4. Identify gaps
# Techniques without detections

# 5. Prioritize remediation
# Based on risk and feasibility
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Testing** | Metasploit, Atomic Red Team (manual) |
| **Detection** | Wazuh, Osquery, Sigma |
| **Analysis** | Wireshark, Yara |
| **Reporting** | Flameshot, Asciinema |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **CALDERA** | Docker | `docker run mitre/caldera` |
| **Detection Lab** | Vagrant | Resource intensive |
| **ATT&CK Navigator** | Web/GitHub | Browser-based |
| **Grafana** | apt or Docker | Dashboard tool |
| **TheHive/Cortex** | apt or Docker | IR platform |
| **MISP** | apt + web setup | TI platform |
| **n8n/Node-RED** | npm/Docker | Automation |
| **Obsidian/Logseq** | Download | Knowledge base |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Red Team** | Receive attack TTPs for testing |
| **Blue Team** | Validate detections, tune rules |
| **Threat Detection** | Share detection rules |
| **Incident Response** | Learn from real incidents |
| **Security Engineer** | Validate control efficacy |
| **Compliance Auditor** | Map to compliance frameworks |

---

## Purple Team Maturity Model

| Level | Name | Characteristics | Next Steps |
|-------|------|-----------------|------------|
| **1** | Initial | Ad-hoc testing, no coordination | Establish Purple function |
| **2** | Developing | Scheduled tests, basic comms | Document processes, measure |
| **3** | Defined | Formal role, regular sims, tracking | Automate testing, expand coverage |
| **4** | Managed | Continuous validation, metrics-driven | TI integration, advanced hunting |
| **5** | Optimized | AI/ML-enhanced, predictive | Innovation, threat intel contribution |

---

## Purple Team Playbook

### Weekly Operations
```
Monday:
  □ Review previous week's tests
  □ Plan this week's simulations
  □ Check detection coverage dashboard

Tuesday:
  □ Execute Atomic Red Team tests
  □ Validate detections
  □ Document results

Wednesday:
  □ Create new detection rules (gaps)
  □ Tune existing rules (false positives)
  □ Update ATT&CK Navigator

Thursday:
  □ Red Team collaboration session
  □ Blue Team detection review
  □ Stakeholder updates

Friday:
  □ Weekly metrics report
  □ Maturity score update
  □ Plan next week
```

### Monthly Operations
```
Week 1:
  □ Full ATT&CK tactic assessment
  □ Coverage gap analysis
  □ Priority setting

Week 2-3:
  □ Focused testing (high-priority gaps)
  □ Detection engineering
  □ Rule deployment

Week 4:
  □ Validation testing
  □ Metrics compilation
  □ Executive reporting
```

---

## Success Metrics

| Metric | Formula | Target |
|--------|---------|--------|
| **ATT&CK Coverage** | (Detected Techniques / Total Techniques) × 100 | >80% |
| **Detection Accuracy** | (True Positives / Total Alerts) × 100 | >90% |
| **Test Pass Rate** | (Passed Tests / Total Tests) × 100 | >95% |
| **Time to Detect** | Average time from test to alert | <5 minutes |
| **Rule Deployment Time** | Time from creation to production | <24 hours |
| **False Positive Rate** | (False Positives / Total Alerts) × 100 | <10% |
| **Maturity Score** | Weighted average of capabilities | Level 3+ |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
