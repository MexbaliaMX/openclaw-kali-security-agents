# 🧪 KaliKlaw Agent Testing Plan

**Objective:** Test the 12 specialized agents in a realistic security audit scenario  
**Environment:** Kali Linux instance (192.168.122.111)  
**Duration:** 60-90 minutes  
**Ethics:** Only test systems you own or have explicit authorization to test

---

## 🎯 Scenario: Security Audit of a Web Application

We'll simulate a complete security engagement from initial assessment to deployment approval, using multiple agents in sequence.

### Target Options (Choose One)

| Option | Target | Setup Required | Risk Level |
|--------|--------|----------------|------------|
| **A. Recommended** | OWASP Juice Shop (local) | `docker run -d -p 3000:3000 bkimminich/juice-shop` | ✅ Safe - Designed for testing |
| **B. Alternative** | DVWA (local) | `docker run -d -p 80:80 vulnerables/web-dvwa` | ✅ Safe - Designed for testing |
| **C. Your App** | Your own web application | None | ⚠️ Only if you own it |

---

## 📋 Testing Phases

### Phase 1: Discovery & Reconnaissance
**Agent:** 🔭 Trend Researcher  
**Task:** Research common vulnerabilities in similar applications

```
Activate Trend Researcher mode

Research the top 10 vulnerabilities for [e-commerce/DVWA/Juice Shop] 
applications based on recent CVE data and OWASP Top 10 2021.

Deliverables:
- Trend brief on common attack vectors
- Competitive analysis of similar vulnerable apps
- Risk assessment with likelihood ratings
```

**Expected Output:** 2-page trend brief with threat landscape

---

### Phase 2: Project Planning
**Agent:** 📋 Project Manager  
**Task:** Create audit project plan

```
Activate Project Manager mode

Create a project plan for a 3-day security audit with these milestones:
- Day 1: Reconnaissance and scanning
- Day 2: Vulnerability analysis and exploitation attempts
- Day 3: Reporting and remediation recommendations

Deliverables:
- Simple project plan with task board
- Risk register with top 5 anticipated risks
- Communication plan for stakeholder updates
```

**Expected Output:** Project plan with timeline, risks, communication cadence

---

### Phase 3: Active Scanning (Manual + Agent Oversight)
**Agent:** 🔒 Security Engineer  
**Task:** Guide security scanning methodology

```
Activate Security Engineer mode

Guide me through a methodical security scan of [target URL].

Deliverables:
- Threat model for the target application
- Scanning checklist based on OWASP Top 10
- Risk classification framework (Critical/High/Medium/Low)
- Recommended tools and commands for each test category
```

**Execute Scans:**
```bash
# Reconnaissance
nmap -sV -sC -oA scans/nmap-full [target]

# Web vulnerability scan
nikto -h [target] -o scans/nikto-report.txt

# Directory enumeration
gobuster dir -u [target] -w /usr/share/wordlists/dirb/common.txt -o scans/gobuster-dir.txt

# If SQL injection testing (only on authorized targets)
sqlmap -u "[target]/vulnerable_endpoint" --batch --safe
```

**Expected Output:** Threat model, scanning methodology, tool recommendations

---

### Phase 4: Code Review (If Source Available)
**Agent:** 👁️ Code Reviewer  
**Task:** Review application code for vulnerabilities

```
Activate Code Reviewer mode

Review this code snippet for security vulnerabilities:
[Paste code from DVWA/Juice Shop or your app]

Focus on:
- SQL injection points
- XSS vulnerabilities
- Authentication/authorization flaws
- Input validation gaps

Deliverables:
- Prioritized findings (🔴 Blocker, 🟡 Suggestion, 💭 Nit)
- Remediation code for each finding
- Security checklist for future development
```

**Expected Output:** Code review with specific findings and fixes

---

### Phase 5: Evidence Collection
**Agent:** 📸 Evidence Collector  
**Task:** QA test findings with visual proof

```
Activate Evidence Collector mode

Review the security scan results and validate findings with evidence.

For each vulnerability found:
- Provide screenshot evidence
- Confirm spec compliance (OWASP Top 10 reference)
- Test interactive elements if applicable
- Rate severity with evidence backing

Deliverables:
- QA evidence report with screenshots
- Specification compliance matrix
- Issues found with priority ratings
- Production readiness assessment (default: FAILED)
```

**Expected Output:** Evidence-based QA report with screenshots, minimum 3-5 issues

---

### Phase 6: Integration Assessment
**Agent:** 🧐 Reality Checker  
**Task:** Final deployment readiness assessment

```
Activate Reality Checker mode

Conduct final integration testing and deployment readiness assessment.

Cross-validate:
- Security Engineer's threat model vs. actual findings
- Code Reviewer's findings vs. scan results
- Evidence Collector's QA report vs. reality

Deliverables:
- Integration report with end-to-end assessment
- User journey testing (if applicable)
- Specification compliance (OWASP Top 10)
- Realistic quality certification (C+/B-/B/B+ only)
- Deployment readiness: FAILED / NEEDS WORK / READY
```

**Expected Output:** Integration report, realistic rating, deployment decision

---

### Phase 7: Compliance Mapping
**Agent:** 📋 Compliance Auditor  
**Task:** Map findings to compliance frameworks

```
Activate Compliance Auditor mode

Map the security findings to compliance frameworks:
- OWASP Top 10 compliance gaps
- SOC 2 CC6.1 (Logical Access) implications
- PCI-DSS requirements (if handling payments)

Deliverables:
- Gap assessment report
- Evidence collection matrix for remediation
- Prioritized remediation plan with effort estimates
- Readiness scorecard
```

**Expected Output:** Compliance gap report, remediation roadmap

---

### Phase 8: Documentation
**Agent:** 📚 Technical Writer  
**Task:** Write final audit report

```
Activate Technical Writer mode

Write a professional security audit report for stakeholders.

Audience: Technical leadership + non-technical executives

Deliverables:
- Executive summary (1 page, non-technical)
- Technical findings with remediation code
- README-style quickstart for developers
- Migration/remediation guide
```

**Expected Output:** Professional audit report, executive summary, developer guide

---

### Phase 9: Incident Response Planning
**Agent:** 🚨 Incident Response Commander  
**Task:** Prepare for potential incidents

```
Activate Incident Response Commander mode

Based on vulnerabilities found, create an incident response plan.

Deliverables:
- Severity classification matrix (SEV1-SEV4)
- Incident response runbook for top 3 risks
- Post-mortem template for when incidents occur
- Communication templates for stakeholders
```

**Expected Output:** IR runbook, severity matrix, communication templates

---

### Phase 10: Reliability Planning
**Agent:** 🛡️ SRE  
**Task:** Define SLOs for security monitoring

```
Activate SRE mode

Define SLOs and monitoring for ongoing security posture.

Deliverables:
- Security SLOs (e.g., vulnerability scan frequency, patch SLA)
- Error budget for security debt
- Observability dashboard recommendations
- Toil reduction opportunities in security operations
```

**Expected Output:** Security SLOs, monitoring recommendations, error budget

---

### Phase 11: Threat Detection Rules
**Agent:** 🎯 Threat Detection Engineer  
**Task:** Create detection rules for discovered vulnerabilities

```
Activate Threat Detection Engineer mode

Create detection rules for the vulnerabilities discovered.

Deliverables:
- Sigma rules for common attack patterns found
- MITRE ATT&CK mapping
- Detection catalog entries
- Hunt playbook for ongoing monitoring
```

**Expected Output:** Sigma rules, ATT&CK mapping, detection catalog

---

### Phase 12: Program Coordination
**Agent:** 📊 Senior Project Manager  
**Task:** Executive summary and program oversight

```
Activate Senior Project Manager mode

Create an executive summary and program-level view of the audit.

Deliverables:
- Project charter summary
- Steering committee presentation
- Risk register at program level
- Resource allocation for remediation
- Stakeholder communication plan
```

**Expected Output:** Executive deck, program risk register, stakeholder comms

---

## 📊 Success Criteria

| Criterion | Target | Measurement |
|-----------|--------|-------------|
| **Agent Activation** | 12/12 agents used | Each agent activated at least once |
| **Deliverables** | 12 reports | One per agent |
| **Evidence Quality** | Screenshots for all claims | Evidence Collector validation |
| **Realistic Ratings** | No A+ fantasies | C+/B-/B/B+ only from Reality Checker |
| **Actionable Findings** | Remediation code provided | Code Reviewer + Technical Writer |
| **Compliance Mapping** | OWASP + 1 framework | Compliance Auditor report |

---

## 🛡️ Ethics & Safety Rules

| Rule | Enforcement |
|------|-------------|
| **Only test authorized targets** | Your own systems or explicit written permission |
| **No production systems** | Use local/dockerized vulnerable apps |
| **Document everything** | Evidence Collector requires screenshots |
| **Report responsibly** | Technical Writer creates professional reports |
| **No data exfiltration** | Keep all testing local |

---

## 📁 Expected File Structure After Test

```
/home/kali/.openclaw/workspace/
├── scans/
│   ├── nmap-full.nmap
│   ├── nikto-report.txt
│   └── gobuster-dir.txt
├── reports/
│   ├── 01-trend-brief.md
│   ├── 02-project-plan.md
│   ├── 03-threat-model.md
│   ├── 04-code-review.md
│   ├── 05-qa-evidence-report.md
│   ├── 06-integration-report.md
│   ├── 07-compliance-gap-assessment.md
│   ├── 08-security-audit-report.md
│   ├── 09-incident-response-runbook.md
│   ├── 10-security-slos.md
│   ├── 11-detection-rules.md
│   └── 12-executive-summary.md
└── agents/
    └── [12 agent files]
```

---

## 🚀 Quick Start

```bash
# 1. Set up target (Option A - Recommended)
docker run -d -p 3000:3000 bkimminich/juice-shop

# 2. Create scan directory
mkdir -p /home/kali/.openclaw/workspace/scans
mkdir -p /home/kali/.openclaw/workspace/reports

# 3. Start testing
# Activate each agent in sequence and save outputs to reports/
```

---

## 📝 Post-Test Review

After completing all phases:

1. **Review deliverables** — Are all 12 reports complete?
2. **Validate evidence** — Do claims have screenshots?
3. **Check ratings** — Are they realistic (no A+ fantasies)?
4. **Assess usefulness** — Would these reports help in a real engagement?
5. **Identify gaps** — Which agents need improvement?

---

*This testing plan validates all 12 agents in a realistic, ethical security audit scenario.*
