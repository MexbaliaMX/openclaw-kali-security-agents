# Red Team / Blue Team / Purple Team - Agent Planning

**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Framework Alignment:** Unified AI Security Framework, NIST CSF, MITRE ATT&CK

---

## Overview

This document plans three specialized security agent modes that work together to provide comprehensive security coverage:

| Team | Focus | Mindset | Primary Goal |
|------|-------|---------|--------------|
| 🔴 **Red Team** | Offensive Security | Attacker | Find vulnerabilities before adversaries do |
| 🔵 **Blue Team** | Defensive Security | Defender | Detect, respond, and recover from attacks |
| 🟣 **Purple Team** | Collaborative Security | Integrator | Maximize security ROI through Red+Blue collaboration |

---

## 🔴 Red Team Agent

### Mission Statement

> "Think like an attacker, act like a professional, document like an auditor."

Simulate real-world adversaries to identify security gaps, test defenses, and validate security controls across people, processes, and technology.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Reconnaissance** | OSINT, subdomain enumeration, DNS analysis, social media scraping | Target profile, attack surface map |
| **Vulnerability Assessment** | Nmap, Nessus, OpenVAS, Nikto, web scanners | Vulnerability list with CVSS scores |
| **Exploitation** | Metasploit, custom exploits, password attacks, web app attacks | System access, proof of compromise |
| **Post-Exploitation** | Privilege escalation, lateral movement, persistence | Domain admin, data access, persistence mechanisms |
| **Physical Security** | Lock picking, badge cloning, tailgating (if authorized) | Physical access to sensitive areas |
| **Social Engineering** | Phishing, vishing, pretexting, impersonation | Credential harvest, access via human element |

### Attack Simulations (MITRE ATT&CK Aligned)

| Tactic | Techniques to Test | Priority |
|--------|-------------------|----------|
| **Initial Access** | Phishing (T1566), Drive-by Compromise (T1189), Valid Accounts (T1078) | 🔴 Critical |
| **Execution** | Command & Scripting (T1059), Native API (T1106) | 🔴 Critical |
| **Persistence** | Scheduled Tasks (T1053), Registry Run Keys (T1547) | 🟠 High |
| **Privilege Escalation** | Exploitation for Privilege Escalation (T1068) | 🟠 High |
| **Defense Evasion** | Obfuscated Files (T1027), Disable Security Tools (T1562) | 🟠 High |
| **Credential Access** | OS Credential Dumping (T1003), Brute Force (T1110) | 🔴 Critical |
| **Discovery** | Network Service Discovery (T1046), Account Discovery (T1087) | 🟡 Medium |
| **Lateral Movement** | SMB/Windows Admin Shares (T1021), RDP (T1021.010) | 🟠 High |
| **Collection** | Data from Local System (T1005), Email Collection (T1114) | 🟡 Medium |
| **Exfiltration** | Exfil Over C2 Channel (T1041), Scheduled Transfer (T1029) | 🟠 High |
| **Impact** | Data Encrypted for Impact (T1486), Data Destruction (T1485) | 🔴 Critical |

### Tools & Skills Integration

| Tool Category | Specific Tools | Skill/Agent Mode |
|---------------|----------------|------------------|
| **Android Pentesting** | jadx, apktool, Frida, Objection | `android-apk-audit` skill |
| **Web App Testing** | Burp Suite, OWASP ZAP, SQLmap | Security Engineer mode |
| **Network Scanning** | Nmap, Masscan, Rustscan | Threat Detection mode |
| **Password Attacks** | John the Ripper, Hashcat, Hydra | Security Engineer mode |
| **Exploitation** | Metasploit, ExploitDB | Security Engineer mode |
| **Wireless Testing** | Aircrack-ng, Kismet, Reaver | Security Engineer mode |
| **Post-Exploitation** | Empire, Covenant, Sliver | Incident Response mode |
| **Reporting** | Dradis, Serpico, custom templates | Technical Writer mode |

### Engagement Rules

```yaml
Pre-Engagement:
  - Written authorization (get it signed!)
  - Scope definition (IPs, domains, systems, people)
  - Rules of engagement (what's off-limits)
  - Emergency contacts (24/7 reachable)
  - Legal review (liability, compliance)

During Engagement:
  - Stay within scope (document any deviations)
  - Avoid destructive testing (unless explicitly authorized)
  - Log all actions (timestamp, target, technique, result)
  - Communicate critical findings immediately
  - Respect production systems (use staging when possible)

Post-Engagement:
  - Deliver detailed report (executive + technical)
  - Include evidence (screenshots, logs, PoC)
  - Provide remediation recommendations
  - Present findings to stakeholders
  - Archive all data securely (then destroy per agreement)
```

### Deliverables

| Document | Audience | Content |
|----------|----------|---------|
| **Executive Summary** | C-level, non-technical | Risk overview, business impact, priority recommendations |
| **Technical Report** | Security team, IT | Detailed findings, CVSS scores, exploitation steps, remediation |
| **Evidence Package** | Auditors, legal | Screenshots, logs, packet captures, proof of access |
| **Remediation Roadmap** | IT operations | Prioritized fix list, effort estimates, timeline |
| **Lessons Learned** | Security team | What worked, what didn't, detection gaps |

---

## 🔵 Blue Team Agent

### Mission Statement

> "Defend the fortress, detect the intruder, destroy the threat."

Protect organizational assets through proactive defense, continuous monitoring, rapid incident response, and security operations excellence.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Security Monitoring** | SIEM, EDR, network sensors, log aggregation | Real-time visibility, alerting |
| **Threat Intelligence** | Open source intel, commercial feeds, ISACs | Contextualized threat data |
| **Incident Response** | Playbooks, forensics, containment, eradication | Incidents resolved, lessons learned |
| **Threat Hunting** | Hypothesis-driven searches, anomaly detection | Proactive threat discovery |
| **Vulnerability Management** | Scanning, prioritization, patch coordination | Reduced attack surface |
| **Security Engineering** | Firewall rules, IDS/IPS, hardening, architecture | Stronger security posture |

### Detection & Response (NIST CSF Aligned)

| Function | Activities | Metrics |
|----------|------------|---------|
| **Detect** | SIEM monitoring, EDR alerts, network analysis, user behavior analytics | MTTD (Mean Time to Detect) |
| **Respond** | Triage, containment, eradication, recovery, communication | MTTR (Mean Time to Respond) |
| **Recover** | System restoration, data recovery, lessons learned, policy updates | Recovery Time Objective (RTO) met |
| **Protect** | Access controls, encryption, segmentation, hardening | Security control coverage % |
| **Identify** | Asset inventory, risk assessments, threat modeling | Asset visibility % |

### Security Operations Center (SOC) Functions

| SOC Level | Responsibilities | Skills Required |
|-----------|------------------|-----------------|
| **SOC Analyst L1** | Alert triage, initial investigation, ticket creation | SIEM basics, log analysis, communication |
| **SOC Analyst L2** | Deep investigation, incident response, threat hunting | Forensics, malware analysis, MITRE ATT&CK |
| **SOC Analyst L3** | Advanced threat hunting, tool development, mentorship | Reverse engineering, scripting, architecture |
| **SOC Manager** | Operations management, reporting, stakeholder communication | Leadership, metrics, budget, strategy |

### Tools & Skills Integration

| Tool Category | Specific Tools | Skill/Agent Mode |
|---------------|----------------|------------------|
| **SIEM** | Splunk, ELK, QRadar, Sentinel | Threat Detection mode |
| **EDR/XDR** | CrowdStrike, SentinelOne, Defender | Threat Detection mode |
| **Network Security** | Snort, Suricata, Zeek, pfSense | Security Engineer mode |
| **Forensics** | Autopsy, Volatility, FTK, Wireshark | Incident Response mode |
| **Threat Intel** | MISP, OpenCTI, Anubis | Threat Detection mode |
| **Vulnerability Mgmt** | Nessus, Qualys, Tenable | Compliance Auditor mode |
| **Incident Response** | TheHive, Cortex, SOAR platforms | Incident Response mode |
| **Threat Hunting** | Velociraptor, KQL, Sigma rules | Threat Detection mode |

### Incident Response Playbook (Aligned with Unified Framework)

```yaml
Phase 1 - Preparation:
  - Maintain IR playbook (updated quarterly)
  - Test communication channels monthly
  - Conduct tabletop exercises quarterly
  - Train team on new threats continuously

Phase 2 - Identification:
  - Receive alert (SIEM, EDR, user report, threat intel)
  - Triage severity (Critical/High/Medium/Low)
  - Assign incident owner
  - Open incident ticket

Phase 3 - Containment:
  - Short-term: Isolate affected systems immediately
  - Long-term: Apply temporary fixes while maintaining operations
  - Document all actions (chain of custody)

Phase 4 - Eradication:
  - Remove malware, backdoors, attacker access
  - Patch vulnerabilities exploited
  - Reset compromised credentials
  - Verify removal (scan, monitor)

Phase 5 - Recovery:
  - Restore systems from clean backups
  - Monitor for re-infection
  - Gradually return to normal operations
  - Validate security controls

Phase 6 - Lessons Learned:
  - Conduct post-mortem within 2 weeks
  - Document what worked, what didn't
  - Update playbooks and detection rules
  - Share learnings with stakeholders
```

### Key Metrics (KPIs)

| Metric | Target | Measurement |
|--------|--------|-------------|
| **MTTD (Mean Time to Detect)** | <1 hour for critical | SIEM/EDR alert timing |
| **MTTR (Mean Time to Respond)** | <4 hours for critical | Incident ticket timestamps |
| **False Positive Rate** | <10% | Alert accuracy analysis |
| **Coverage** | 100% of critical assets | Asset inventory vs. monitored |
| **Patch Compliance** | >95% within SLA | Vulnerability scanner reports |
| **Phishing Test Failure Rate** | <5% | Simulated phishing results |

---

## 🟣 Purple Team Agent

### Mission Statement

> "Bridge the gap, amplify the signal, maximize the security ROI."

Facilitate continuous collaboration between Red and Blue teams to ensure attack simulations directly improve defensive capabilities, and defensive gaps inform attack testing priorities.

### Core Capabilities

| Capability | Activities | Output |
|------------|------------|--------|
| **Collaboration Facilitation** | Joint exercises, shared tooling, communication channels | Improved Red↔Blue communication |
| **Attack Simulation Coordination** | Scheduled tests, controlled exercises, detection validation | Measured detection coverage |
| **Detection Engineering** | Translate TTPs to detection rules, validate alerts | High-fidelity detection rules |
| **Security Control Validation** | Test security tools, measure effectiveness | Control efficacy reports |
| **Knowledge Transfer** | Training, documentation, playbooks shared | Elevated team capabilities |
| **Metrics & Reporting** | Coverage analysis, ROI measurement, maturity tracking | Executive dashboards, maturity scores |

### Purple Team Engagement Model

```
┌─────────────────────────────────────────────────────────────────┐
│                    Purple Team Cycle                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   ┌──────────┐     ┌──────────┐     ┌──────────┐               │
│   │  RED     │────▶│  PURPLE  │────▶│  BLUE    │               │
│   │  Attack  │     │  Enable  │     │  Detect  │               │
│   └──────────┘     └──────────┘     └──────────┘               │
│        │                  │                  │                  │
│        │                  │                  │                  │
│        ▼                  ▼                  ▼                  │
│   ┌──────────┐     ┌──────────┐     ┌──────────┐               │
│   │  Report  │◀────│  Measure │◀────│  Respond │               │
│   │  Findings│     │  Coverage│     │  & Learn │               │
│   └──────────┘     └──────────┘     └──────────┘               │
│                                                                  │
│                    Repeat & Improve                              │
└─────────────────────────────────────────────────────────────────┘
```

### Purple Team Activities

| Activity Type | Description | Frequency | Participants |
|---------------|-------------|-----------|--------------|
| **Tabletop Exercises** | Discussion-based scenario walkthroughs | Monthly | Red + Blue + Stakeholders |
| **Controlled Attack Simulations** | Live-fire tests with Blue team awareness | Bi-weekly | Red + Blue (Purple facilitates) |
| **Detection Rule Validation** | Test if alerts fire for specific TTPs | Per engagement | Red + Blue |
| **Threat Hunting Collaboration** | Joint hypothesis-driven hunts | Monthly | Red + Blue analysts |
| **Tool Testing** | Validate security tool efficacy | Quarterly | Red + Blue + Purple |
| **Maturity Assessments** | Measure security program progress | Quarterly | Purple leads, all contribute |

### MITRE ATT&CK Coverage Mapping

Purple Team tracks detection coverage across MITRE ATT&CK:

```
┌─────────────────────────────────────────────────────────────────┐
│              MITRE ATT&CK Coverage Matrix                       │
├──────────────┬────────────┬────────────┬────────────┬───────────┤
│   Tactic     │   Red      │   Blue     │   Purple   │  Coverage │
│              │   Tested   │   Detected │   Validated│    %      │
├──────────────┼────────────┼────────────┼────────────┼───────────┤
│ Initial Access │   15/20   │   12/20    │   12/15    │    80%    │
│ Execution      │   10/15   │    8/15    │    8/10    │    80%    │
│ Persistence    │   20/25   │   15/25    │   15/20    │    75%    │
│ Privilege Esc  │   12/18   │    9/18    │    9/12    │    75%    │
│ Defense Evasion│   18/22   │   10/22    │   10/18    │    56%    │
│ Credential Acc │   14/16   │   11/16    │   11/14    │    79%    │
│ Discovery      │   10/12   │    8/12    │    8/10    │    80%    │
│ Lateral Move   │   16/20   │   12/20    │   12/16    │    75%    │
│ Collection     │    8/12   │    6/12    │    6/8     │    75%    │
│ Exfiltration   │   10/14   │    7/14    │    7/10    │    70%    │
│ Impact         │   12/15   │   10/15    │   10/12    │    83%    │
├──────────────┼────────────┼────────────┼────────────┼───────────┤
│ TOTAL          │  145/189  │  108/189   │  108/145   │    74%    │
└──────────────┴────────────┴────────────┴────────────┴───────────┘
```

### Tools & Skills Integration

| Tool Category | Specific Tools | Skill/Agent Mode |
|---------------|----------------|------------------|
| **Attack Simulation** | CALDERA, Atomic Red Team, Mitre Attack | Security Engineer mode |
| **Detection Testing** | Sigma, Detection Lab, Wazuh | Threat Detection mode |
| **Coverage Mapping** | MITRE ATT&CK Navigator, custom dashboards | Compliance Auditor mode |
| **Collaboration** | Slack/Teams channels, shared wikis, Jira | Project Manager mode |
| **Reporting** | Dashboards, maturity models, executive reports | Technical Writer + Senior PM |
| **Automation** | SOAR, custom scripts, APIs | MCP Builder mode |

### Purple Team Maturity Model

| Level | Name | Characteristics | Next Steps |
|-------|------|-----------------|------------|
| **1** | Initial | Ad-hoc Red/Blue activities, no coordination | Establish Purple function |
| **2** | Developing | Scheduled exercises, basic communication | Document processes, measure coverage |
| **3** | Defined | Formal Purple role, regular simulations, coverage tracking | Automate testing, expand TTP coverage |
| **4** | Managed | Continuous validation, metrics-driven, integrated tooling | Threat intel integration, advanced hunting |
| **5** | Optimized | AI/ML-enhanced, predictive defense, industry leadership | Innovation, threat intel contribution |

### Purple Team Deliverables

| Deliverable | Audience | Frequency |
|-------------|----------|-----------|
| **Coverage Dashboard** | Security leadership | Weekly |
| **Detection Efficacy Report** | Blue team, SOC | Per engagement |
| **Attack Simulation Summary** | Red team, stakeholders | Per engagement |
| **Maturity Assessment** | CISO, executives | Quarterly |
| **Detection Rule Package** | Blue team, SOC | Per TTP tested |
| **Remediation Tracking** | IT operations, management | Weekly |
| **Threat Intel Integration Report** | All teams | Monthly |

---

## Team Integration Matrix

### How the Three Teams Work Together

| Scenario | Red Team Role | Blue Team Role | Purple Team Role |
|----------|---------------|----------------|------------------|
| **New Threat Emerges** | Research TTPs, simulate attack | Update detection rules, monitor | Facilitate knowledge transfer, validate detections |
| **Security Tool Deployment** | Test tool efficacy, find bypasses | Configure, tune, operate | Measure coverage, report ROI |
| **Incident Response** | Provide attacker perspective | Lead response, containment | Document lessons, update playbooks |
| **Compliance Audit** | Demonstrate control testing | Show operational evidence | Map to frameworks, report coverage |
| **Security Training** | Present attack techniques | Share detection methods | Create integrated training materials |
| **Budget Planning** | Identify tool gaps | Prioritize operational needs | Quantify ROI, maturity progression |

---

## Agent Mode Activation

### Proposed New Agent Modes

| Agent Mode | Activation Command | Primary Use Case |
|------------|-------------------|------------------|
| 🔴 **Red Team Operator** | `"Activate Red Team mode"` | Penetration testing, attack simulation, vulnerability assessment |
| 🔵 **Blue Team Defender** | `"Activate Blue Team mode"` | SOC operations, incident response, threat hunting, detection engineering |
| 🟣 **Purple Team Integrator** | `"Activate Purple Team mode"` | Red/Blue collaboration, coverage validation, security program maturity |

### Mapping to Existing Agents

| Existing Agent | Team Alignment | Notes |
|----------------|----------------|-------|
| Security Engineer | 🔴 Red / 🔵 Blue | Can operate in both modes |
| Incident Response | 🔵 Blue | Core Blue Team function |
| Threat Detection | 🔵 Blue | SOC/Blue Team primary |
| Compliance Auditor | 🟣 Purple | Coverage validation, framework mapping |
| Technical Writer | 🟣 Purple | Documentation, knowledge transfer |
| Project Manager | 🟣 Purple | Coordination, tracking |

---

## Implementation Roadmap

### Phase 1: Foundation (Weeks 1-4)

| Week | Task | Owner |
|------|------|-------|
| 1 | Define Red Team scope and rules of engagement | Security Lead |
| 2 | Establish Blue Team SOC functions and playbooks | SOC Manager |
| 3 | Assign Purple Team facilitator role | Security Lead |
| 4 | Conduct first tabletop exercise (all teams) | Purple Team |

### Phase 2: Operations (Weeks 5-12)

| Week | Task | Owner |
|------|------|-------|
| 5-6 | Red Team: Initial penetration test | Red Team |
| 7-8 | Blue Team: Detection rule tuning based on findings | Blue Team |
| 9-10 | Purple Team: Coverage validation, gap analysis | Purple Team |
| 11-12 | Joint review, playbook updates | All Teams |

### Phase 3: Maturation (Weeks 13-24)

| Week | Task | Owner |
|------|------|-------|
| 13-16 | Automated attack simulation (CALDERA/Atomic) | Purple Team |
| 17-20 | Continuous detection validation pipeline | Blue + Purple |
| 21-24 | Maturity assessment, executive reporting | Purple Team |

---

## Success Metrics

| Metric | Red Team | Blue Team | Purple Team |
|--------|----------|-----------|-------------|
| **Primary KPI** | Vulnerabilities found | MTTD/MTTR | Coverage % |
| **Secondary** | Critical systems tested | False positive rate | Maturity score |
| **Outcome** | Remediation rate | Incidents contained | Detection efficacy |
| **Business** | Risk reduction | Downtime avoided | Security ROI |

---

## References

| Source | Relevance |
|--------|-----------|
| **MITRE ATT&CK** | TTP framework for all teams |
| **NIST CSF** | Blue Team alignment (Detect, Respond, Recover) |
| **Unified AI Security Framework** | Overall security program integration |
| **OWASP** | Web app testing (Red Team) |
| **CERT-MX / FTC** | Human factor, training (all teams) |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Next Review:** Quarterly (align with Purple Team maturity assessments)  
**Owner:** Security Team
