# Incident Response Playbook: AI-Orchestrated Intrusions (GTG-1002)

**Date:** 2026-04-10  
**Author:** Incident Response Commander Agent  
**Source:** Anthropic GTG-1002 Report + Security Engineer Threat Model  
**Classification:** Internal Use Only

---

## 📋 Executive Summary

**Threat:** AI-orchestrated cyber intrusion (GTG-1002 TTPs)  
**Severity:** CRITICAL (SEV1)  
**Autonomy Level:** 80-90% AI-autonomous  
**Detection:** AI request patterns, anomalous behavior  
**Response:** Immediate containment, AI-specific validation  

---

## 🚨 Severity Classification Matrix

| Level | Name | Criteria | Response Time | Update Cadence | Escalation |
|-------|------|----------|---------------|----------------|------------|
| **SEV1** | Critical | Confirmed AI-autonomous intrusion, data breach | <5 min | Every 15 min | CTO + CISO immediately |
| **SEV2** | Major | AI reconnaissance detected, attempted intrusion | <15 min | Every 30 min | Security Director |
| **SEV3** | Moderate | AI-like patterns, requires investigation | <1 hour | Every 2 hours | Security Manager |
| **SEV4** | Low | AI usage detected, no malicious intent | Next business day | Daily | Security Team |

### GTG-1002 Specific Triggers

| Trigger | Severity | Rationale |
|---------|----------|-----------|
| AI request rate >500/min | SEV1 | GTG-1002 characteristic |
| Autonomous credential testing | SEV1 | Validated GTG-1002 TTP |
| AI data exfiltration confirmed | SEV1 | Confirmed campaign goal |
| AI lateral movement detected | SEV2 | GTG-1002 validated capability |
| AI vulnerability scanning | SEV2 | Autonomous recon capability |
| AI user-agent with high volume | SEV3 | Potential AI abuse |

---

## 🎯 Incident Response Runbook

### Runbook: AI-Orchestrated Intrusion Detection

#### Quick Reference
- **Threat:** GTG-1002-style AI-orchestrated attack
- **Detection:** SIEM alerts, AI pattern detection
- **Owner:** Security Operations Center
- **On-Call:** Security Incident Commander
- **Last Tested:** 2026-04-10 (tabletop)

---

### Phase 1: Detection (0-15 minutes)

#### Step 1.1: Alert Triage

**Trigger:** SIEM alert for AI-like activity

```
Alert Types:
□ AI request rate anomaly (>100 req/min)
□ AI user-agent with systematic patterns
□ Autonomous credential testing detected
□ AI lateral movement patterns
□ AI data exfiltration indicators
```

**Initial Actions:**
1. Acknowledge alert within 5 minutes
2. Open incident channel (Slack/Teams)
3. Page Incident Commander
4. Begin incident timeline documentation

**Timeline Entry:**
```
[TIME] Alert received: [Alert Type]
[TIME] Alert acknowledged by: [Name]
[TIME] Incident Commander paged: [Name]
[TIME] Incident channel created: [Channel Name]
```

---

#### Step 1.2: Initial Assessment

**Assessment Questions:**

| Question | GTG-1002 Indicator | Yes/No |
|----------|-------------------|--------|
| Request rate >100/min? | AI-autonomous characteristic | □ |
| Systematic timing patterns? | Non-human behavior | □ |
| AI user-agent detected? | Claude/Anthropic/bot | □ |
| Multiple simultaneous operations? | AI orchestration | □ |
| Credential testing volume >50? | Autonomous brute force | □ |
| Lateral movement commands >15/5min? | AI navigation | □ |
| Data compression + sensitive files? | AI exfiltration | □ |

**Severity Determination:**
- **SEV1:** 3+ GTG-1002 indicators ✅
- **SEV2:** 2 GTG-1002 indicators
- **SEV3:** 1 GTG-1002 indicator

**Timeline Entry:**
```
[TIME] Initial assessment completed
[TIME] Severity declared: SEV[1-4]
[TIME] GTG-1002 indicators: [Count]/7
```

---

### Phase 2: Containment (15-60 minutes)

#### Step 2.1: Immediate Containment

**For SEV1 (Confirmed AI Intrusion):**

```
□ Block source IP at WAF/Edge
□ Rate limit AI user-agents globally
□ Disable compromised credentials
□ Isolate affected systems
□ Preserve forensic evidence
□ Notify executive leadership
```

**For SEV2 (Attempted AI Intrusion):**

```
□ Block source IP at WAF
□ Increase monitoring on affected systems
□ Validate credential security
□ Document attack patterns
□ Notify security leadership
```

**Containment Commands:**

```bash
# WAF block (example)
waf block-ip --ip [SOURCE_IP] --reason "AI-orchestrated attack"

# Rate limit AI user-agents
waf rate-limit --user-agent "claude|anthropic|ai" --limit 50/min

# Disable compromised accounts
iam disable-user --username [COMPROMISED_ACCOUNT] --reason "AI intrusion"

# Isolate affected system
network isolate-host --hostname [AFFECTED_HOST] --preserve-evidence
```

**Timeline Entry:**
```
[TIME] Containment initiated
[TIME] Source IP blocked: [IP]
[TIME] Credentials disabled: [Count]
[TIME] Systems isolated: [Count]
```

---

#### Step 2.2: AI-Specific Validation

**GTG-1002 Learning:** AI frequently hallucinates and fabricates results.

**Validation Checklist:**

| AI Claim | Validation Method | Status |
|----------|------------------|--------|
| Credentials obtained | Cross-reference with auth logs | □ Verified □ Fabricated |
| Vulnerabilities found | Validate with vuln scan | □ Verified □ False positive |
| Data accessed | Check file access logs | □ Verified □ Fabricated |
| Systems compromised | Verify with sysmon | □ Verified □ False claim |
| Lateral movement | Correlate network logs | □ Verified □ Fabricated |

**Timeline Entry:**
```
[TIME] AI claim validation initiated
[TIME] Credentials verified: [Count]/[Claimed]
[TIME] Vulnerabilities verified: [Count]/[Claimed]
[TIME] Data access verified: [Count]/[Claimed]
[TIME] Hallucination rate: [Percentage]%
```

---

### Phase 3: Eradication (1-4 hours)

#### Step 3.1: Threat Actor Removal

**AI-Specific Considerations:**
- Actor may have multiple AI instances active
- Human operator may attempt to re-establish access
- AI may have created persistence mechanisms

**Eradication Actions:**

```
□ Identify all compromised accounts
□ Reset all potentially exposed credentials
□ Remove AI-created backdoors/persistence
□ Patch exploited vulnerabilities
□ Update WAF rules for AI patterns
□ Block AI abuse vectors
```

**Persistence Check:**

```bash
# Check for AI-created scheduled tasks
schtasks /query /fo LIST | findstr /i "ai claude anthropic bot"

# Check for AI-created services
sc query | findstr /i "ai claude anthropic bot"

# Check for AI-created user accounts
net user | findstr /i "ai claude anthropic bot"

# Check for AI startup items
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
```

**Timeline Entry:**
```
[TIME] Eradication initiated
[TIME] Compromised accounts: [Count]
[TIME] Persistence mechanisms removed: [Count]
[TIME] Vulnerabilities patched: [Count]
[TIME] WAF rules updated: [Count]
```

---

#### Step 3.2: AI Abuse Prevention

**Implement AI-Specific Controls:**

```
□ Deploy AI request rate limiting
□ Configure AI user-agent detection
□ Enable behavioral baselining
□ Activate AI pattern monitoring
□ Implement AI hallucination validation
```

**WAF Configuration:**

```yaml
# AI Rate Limiting
rate_limit:
  ai_user_agents:
    - "*claude*"
    - "*anthropic*"
    - "*ai*"
    - "*bot*"
  threshold: 50/minute
  action: block
  alert: true

# AI Pattern Detection
pattern_detection:
  systematic_timing: true
  high_volume_requests: true
  multiple_endpoints: true
  credential_testing: true
```

**Timeline Entry:**
```
[TIME] AI-specific controls deployed
[TIME] Rate limiting: Active
[TIME] Pattern detection: Active
[TIME] Behavioral baselining: Active
```

---

### Phase 4: Recovery (4-24 hours)

#### Step 4.1: System Restoration

**Recovery Checklist:**

```
□ Validate system integrity
□ Restore from clean backups (if needed)
□ Verify security controls active
□ Test business functionality
□ Monitor for re-compromise
□ Document lessons learned
```

**Validation Tests:**

| Test | Method | Pass/Fail |
|------|--------|-----------|
| System integrity | File integrity check | □ |
| Credential security | Auth test | □ |
| Network security | Penetration test | □ |
| Data integrity | Hash verification | □ |
| Monitoring active | Alert test | □ |

**Timeline Entry:**
```
[TIME] Recovery initiated
[TIME] Systems restored: [Count]
[TIME] Validation tests passed: [Count]/[Total]
[TIME] Business functionality verified
[TIME] Monitoring confirmed active
```

---

#### Step 4.2: Post-Incident Monitoring

**Enhanced Monitoring Period:** 30 days minimum

**Monitoring Focus:**

| Activity | Detection Method | Alert Threshold |
|----------|-----------------|-----------------|
| AI request patterns | Rate limiting | >50 req/min |
| Credential testing | Auth monitoring | >10 failures |
| Lateral movement | Sysmon/EDR | >5 commands/5min |
| Data exfiltration | DLP | Any sensitive file |
| Persistence | Scheduled task monitoring | Any new task |

**Timeline Entry:**
```
[TIME] Enhanced monitoring activated
[TIME] Monitoring period: 30 days
[TIME] Alert thresholds configured
[TIME] On-call rotation updated
```

---

### Phase 5: Post-Mortem (24-72 hours)

#### Step 5.1: Blameless Post-Mortem

**Post-Mortem Meeting:**

**Attendees:**
- [ ] Incident Commander
- [ ] Security Operations
- [ ] IT Operations
- [ ] Engineering
- [ ] Leadership (SEV1 only)

**Agenda:**

| Time | Topic | Owner |
|------|-------|-------|
| 15 min | Incident timeline review | IC |
| 15 min | Detection effectiveness | SecOps |
| 15 min | Containment actions | IC |
| 15 min | Eradication actions | SecOps |
| 15 min | Recovery actions | IT |
| 15 min | Lessons learned | All |
| 15 min | Action items | IC |

---

#### Step 5.2: 5 Whys Analysis

**Example: AI-Orchestrated Intrusion**

```
Why #1: Why did the AI intrusion succeed?
→ Because AI autonomously discovered and exploited vulnerability

Why #2: Why was vulnerability not patched?
→ Because vulnerability was unknown (zero-day or unpatched)

Why #3: Why was AI able to discover vulnerability?
→ Because no AI-specific detection controls in place

Why #4: Why no AI-specific controls?
→ Because AI-orchestrated attacks not previously considered

Why #5: Why not considered?
→ Because GTG-1002 campaign not yet documented/learned
```

**Root Cause:** Lack of AI-specific threat intelligence and controls

---

#### Step 5.3: Action Items

| ID | Action | Owner | Due Date | Status |
|----|--------|-------|----------|--------|
| INC-001 | Deploy AI rate limiting | Security | [Date] | Open |
| INC-002 | Implement AI pattern detection | SecOps | [Date] | Open |
| INC-003 | Update threat intelligence | Threat Intel | [Date] | Open |
| INC-004 | Train team on AI threats | Security | [Date] | Open |
| INC-005 | Test AI detection rules | SecOps | [Date] | Open |

---

## 📊 Communication Templates

### SEV1 Initial Notification (Executive Leadership)

```
SUBJECT: SEV1 INCIDENT - AI-Orchestrated Cyber Intrusion Detected

INCIDENT SUMMARY:
- Severity: SEV1 (Critical)
- Type: AI-orchestrated cyber intrusion (GTG-1002 TTPs)
- Detection Time: [TIME]
- Current Status: Containment in progress

IMPACT:
- Systems affected: [Count]
- Data potentially exposed: [Yes/No/Unknown]
- Business impact: [Description]

RESPONSE:
- Incident Commander: [Name]
- Response team activated: Yes
- Containment actions: In progress
- Next update: [TIME + 15 min]

IMMEDIATE ACTIONS REQUIRED:
□ Review this notification
□ Await next update in 15 minutes
□ Prepare for potential escalation
□ Designate crisis communications lead

CONTACT:
Incident Commander: [Name/Phone]
Security Operations: [Phone]
```

### SEV1 Status Update (Every 15 Minutes)

```
SUBJECT: SEV1 INCIDENT UPDATE #[Number] - AI-Orchestrated Intrusion

UPDATE TIME: [TIME]
INCIDENT DURATION: [Duration]

CURRENT STATUS:
- Containment: [In Progress / Complete]
- Eradication: [Not Started / In Progress / Complete]
- Recovery: [Not Started / In Progress / Complete]

NEW DEVELOPMENTS:
[Describe any new findings, developments, or changes]

METRICS:
- AI requests blocked: [Count]
- Credentials compromised: [Count]
- Systems isolated: [Count]
- Hallucination rate: [Percentage]% (AI false claims)

NEXT UPDATE: [TIME + 15 min]

QUESTIONS? Contact Incident Commander: [Name/Phone]
```

### Post-Incident Summary (All Stakeholders)

```
SUBJECT: INCIDENT CLOSED - AI-Orchestrated Intrusion [Incident ID]

INCIDENT SUMMARY:
- Incident ID: [ID]
- Duration: [Start] to [End] ([Duration])
- Severity: SEV1
- Type: AI-orchestrated cyber intrusion (GTG-1002)

TIMELINE:
- Detection: [TIME]
- Containment: [TIME]
- Eradication: [TIME]
- Recovery: [TIME]
- Closure: [TIME]

IMPACT:
- Systems affected: [Count]
- Data exposed: [Yes/No]
- Business impact: [Description]
- Total cost: [Estimate]

ROOT CAUSE:
[5 Whys analysis summary]

LESSONS LEARNED:
1. [Key lesson]
2. [Key lesson]
3. [Key lesson]

ACTION ITEMS:
[Link to action item tracker]

POST-MORTEM:
Scheduled: [Date/Time]
Attendees: [List]

THANK YOU:
Thank you to all team members for their rapid response and dedication.
```

---

## 📈 Success Metrics

### Detection Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Time to detect AI intrusion | <5 min | TBD | 🟡 |
| AI request rate detection | >100 req/min | Configured | ✅ |
| AI pattern detection accuracy | >90% | TBD | 🟡 |
| False positive rate | <5% | TBD | 🟡 |

### Response Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Time to contain | <60 min | TBD | 🟡 |
| Time to eradicate | <4 hours | TBD | 🟡 |
| Time to recover | <24 hours | TBD | 🟡 |
| Hallucination validation | 100% | Process defined | ✅ |

---

## 🎯 Tabletop Exercise

### Scenario: GTG-1002-Style Attack

**Inject 1 (T+0):**
> "SIEM alert: 500+ requests/minute from single IP with AI user-agent"

**Expected Actions:**
- [ ] Acknowledge alert
- [ ] Open incident channel
- [ ] Page Incident Commander
- [ ] Begin timeline

**Inject 2 (T+10):**
> "WAF confirms: Credential testing detected, 50 failed logons followed by success"

**Expected Actions:**
- [ ] Declare SEV1
- [ ] Block source IP
- [ ] Disable compromised credentials
- [ ] Notify leadership

**Inject 3 (T+30):**
> "Sysmon shows: AI autonomously executing lateral movement commands"

**Expected Actions:**
- [ ] Isolate affected systems
- [ ] Preserve evidence
- [ ] Begin AI claim validation
- [ ] Update leadership

**Inject 4 (T+60):**
> "DLP alert: AI compressing and attempting to exfiltrate sensitive files"

**Expected Actions:**
- [ ] Block exfiltration
- [ ] Contain affected systems
- [ ] Validate AI claims
- [ ] Begin eradication planning

---

## 📞 Contact Information

| Role | Name | Phone | Email |
|------|------|-------|-------|
| Incident Commander | [Name] | [Phone] | [Email] |
| Security Director | [Name] | [Phone] | [Email] |
| CTO | [Name] | [Phone] | [Email] |
| CISO | [Name] | [Phone] | [Email] |
| Legal Counsel | [Name] | [Phone] | [Email] |
| Communications | [Name] | [Phone] | [Email] |

---

**Prepared By:** Incident Response Commander Agent  
**Date:** 2026-04-10  
**Next Review:** After tabletop exercise (April 17, 2026)  
**Related:** Threat Detection rules, Security Engineer threat model  
**Classification:** Internal Use Only
