# Implementation Plan: Security Fixes for mexbalia.com & mexbalia.mx

**Date:** 2026-04-10  
**Project Manager:** Senior Project Manager Agent  
**Project:** Coordinated Security Remediation  
**Domains:** mexbalia.com + mexbalia.mx  
**Estimated Duration:** 2-4 weeks  
**Total Effort:** 10.5 hours (coordinated)

---

## 📋 Executive Summary

### Project Overview

| Attribute | Details |
|-----------|---------|
| **Project Name** | Operation: Dual Domain Security Hardening |
| **Sponsor** | Wulfrano Moreno (Owner) |
| **Project Manager** | Senior Project Manager Agent |
| **Start Date** | 2026-04-10 |
| **Target End Date** | 2026-05-10 |
| **Budget** | Internal effort only (10.5 hours) |
| **Risk Reduction** | 60% (Week 1) + 25% (Week 2-4) = 85% total |

### Business Case

**Current State:**
- Both domains rated **B- (6.5/10)** security posture
- Critical security header gaps (0-1/8 implemented)
- REST API user enumeration vulnerability
- Unknown 2FA enforcement status
- OWASP compliance: 50%

**Target State:**
- Both domains rated **A- (9/10)** security posture
- All 8 security headers implemented
- REST API protected
- 2FA enforced for all admins
- OWASP compliance: 90%

**ROI:**
- Effort: 10.5 hours (coordinated) vs 21 hours (separate)
- **Savings: 50% (10.5 hours)**
- Risk reduction: 85%
- Compliance improvement: 50% → 90%

---

## 🎯 Project Scope

### In Scope

| Item | mexbalia.com | mexbalia.mx | Priority |
|------|--------------|-------------|----------|
| Security headers plugin | ✅ | ✅ | 🔴 Critical |
| REST API protection | ✅ | ✅ | 🔴 High |
| 2FA enforcement | ✅ | ✅ | 🔴 High |
| Plugin audit & updates | ✅ | ✅ | 🟠 High |
| Security plugin (Wordfence) | ✅ | ✅ | 🟠 Medium |
| Daily backups | ✅ | ✅ | 🔴 Critical |
| Uptime monitoring | ✅ | ✅ | 🟡 Medium |
| Security documentation | ✅ | ✅ | 🟡 Medium |

### Out of Scope

| Item | Rationale |
|------|-----------|
| Infrastructure changes | No hosting migration planned |
| CMS migration | WordPress to remain |
| Major redesign | Security-only focus |
| Third-party integrations | No new integrations |

---

## 📅 Project Timeline

### Gantt Chart Overview

```
Week 1 (Apr 10-17): Critical Fixes
├─ Day 1-2: Security headers plugin    ████████
├─ Day 2-3: REST API protection        ████████
├─ Day 3-4: 2FA enforcement            ████████
└─ Day 4-5: Plugin audit & updates     ████████

Week 2 (Apr 17-24): Hardening
├─ Security plugin (Wordfence)         ████████
└─ Daily backups configuration         ████████

Week 3 (Apr 24-May 1): Monitoring
├─ Uptime monitoring setup             ████████
└─ Documentation                       ████████

Week 4 (May 1-10): Validation
├─ Testing & validation                ████████
└─ Re-audit preparation                ████████
```

---

## 📊 Work Breakdown Structure

### Phase 1: Week 1 - Critical Fixes (4.5 hours)

#### Task 1.1: Security Headers Plugin
| Attribute | Details |
|-----------|---------|
| **ID** | W1-T1 |
| **Description** | Install and configure security headers plugin on both domains |
| **Effort** | 30 minutes |
| **Owner** | Dev Team |
| **Priority** | 🔴 Critical |
| **Dependencies** | None |
| **Acceptance Criteria** | All 8 security headers present on both domains |

**Implementation Steps:**
1. Install "HTTP Headers" plugin on mexbalia.com
2. Configure 8 security headers
3. Test headers with curl
4. Repeat for mexbalia.mx
5. Document configuration

**Verification Command:**
```bash
curl -I https://mexbalia.com | grep -E "strict-transport-security|content-security-policy|x-frame-options|x-content-type-options|x-xss-protection|referrer-policy|permissions-policy"
curl -I https://mexbalia.mx | grep -E "strict-transport-security|content-security-policy|x-frame-options|x-content-type-options|x-xss-protection|referrer-policy|permissions-policy"
```

---

#### Task 1.2: REST API Protection
| Attribute | Details |
|-----------|---------|
| **ID** | W1-T2 |
| **Description** | Disable REST API user enumeration on both domains |
| **Effort** | 15 minutes |
| **Owner** | Dev Team |
| **Priority** | 🔴 High |
| **Dependencies** | None |
| **Acceptance Criteria** | /wp-json/wp/v2/users returns 403 on both domains |

**Implementation Steps:**
1. Add code to theme's functions.php (both domains)
2. Test endpoint returns 403
3. Verify legitimate API functions still work
4. Document changes

**Code:**
```php
// Add to functions.php on both domains
add_filter('rest_endpoints', function($endpoints) {
    if (isset($endpoints['/wp/v2/users'])) {
        unset($endpoints['/wp/v2/users']);
    }
    if (isset($endpoints['/wp/v2/users/(?P<id>[\d]+)'])) {
        unset($endpoints['/wp/v2/users/(?P<id>[\d]+)']);
    }
    return $endpoints;
});
```

**Verification Command:**
```bash
curl https://mexbalia.com/wp-json/wp/v2/users
# Expected: {"code":"rest_forbidden","message":"...","data":{"status":403}}

curl https://mexbalia.mx/wp-json/wp/v2/users
# Expected: {"code":"rest_forbidden","message":"...","data":{"status":403}}
```

---

#### Task 1.3: 2FA Enforcement
| Attribute | Details |
|-----------|---------|
| **ID** | W1-T3 |
| **Description** | Enable 2FA for all admin accounts on both domains |
| **Effort** | 30 minutes |
| **Owner** | IT Admin |
| **Priority** | 🔴 High |
| **Dependencies** | None |
| **Acceptance Criteria** | All admin accounts have 2FA enabled |

**Implementation Steps:**
1. Install "WP 2FA" plugin on both domains
2. Configure 2FA policy (enforce for administrators)
3. Enable 2FA for each admin account
4. Test 2FA login flow
5. Document backup codes storage

**Configuration:**
- Plugin: WP 2FA (free)
- Policy: Enforce for Administrator role
- Grace period: 7 days
- Backup codes: Store securely offline

---

#### Task 1.4: Plugin Audit & Updates
| Attribute | Details |
|-----------|---------|
| **ID** | W1-T4 |
| **Description** | Audit all plugins and update to latest versions |
| **Effort** | 2 hours |
| **Owner** | Dev Team |
| **Priority** | 🟠 High |
| **Dependencies** | None |
| **Acceptance Criteria** | All plugins updated, unused plugins removed |

**Implementation Steps:**
1. Export plugin list (both domains)
2. Check for updates available
3. Update all plugins (staging first, then production)
4. Remove inactive/unused plugins
5. Research plugins not updated in 6+ months
6. Test site functionality after updates
7. Document plugin inventory

**Plugin Inventory Template:**
```
Domain: mexbalia.com / mexbalia.mx
Date: 2026-04-10

| Plugin Name | Version | Status | Last Updated | Action |
|-------------|---------|--------|--------------|--------|
| [Plugin]    | [X.Y.Z] | Active | [Date]       | Keep/Update/Remove |
```

---

### Phase 2: Week 2 - Hardening (3 hours)

#### Task 2.1: Security Plugin (Wordfence)
| Attribute | Details |
|-----------|---------|
| **ID** | W2-T1 |
| **Description** | Install and configure Wordfence Security plugin |
| **Effort** | 1 hour |
| **Owner** | Security Team |
| **Priority** | 🟠 Medium |
| **Dependencies** | W1-T1, W1-T2 complete |
| **Acceptance Criteria** | Wordfence active with WAF enabled |

**Configuration:**
- Plugin: Wordfence Security (free)
- WAF: Enabled
- Scan schedule: Daily
- Login security: Enable rate limiting
- Alerts: Email notifications

---

#### Task 2.2: Daily Backups
| Attribute | Details |
|-----------|---------|
| **ID** | W2-T2 |
| **Description** | Configure daily automated backups for both domains |
| **Effort** | 1 hour |
| **Owner** | IT Admin |
| **Priority** | 🔴 Critical |
| **Dependencies** | None |
| **Acceptance Criteria** | Daily backups running, offsite storage configured |

**Configuration:**
- Plugin: UpdraftPlus (free)
- Schedule: Daily (files), Hourly (database if possible)
- Storage: Google Drive / Dropbox / S3 (NOT same server)
- Retention: 14 daily backups
- Test: Restoration test required

---

### Phase 3: Week 3 - Monitoring (1.5 hours)

#### Task 3.1: Uptime Monitoring
| Attribute | Details |
|-----------|---------|
| **ID** | W3-T1 |
| **Description** | Set up uptime and performance monitoring |
| **Effort** | 30 minutes |
| **Owner** | SecOps |
| **Priority** | 🟡 Medium |
| **Dependencies** | None |
| **Acceptance Criteria** | Both domains monitored, alerts configured |

**Tools:**
- Uptime Robot (free): 50 monitors, 5-minute checks
- Alerts: Email + SMS for downtime >15 minutes
- Status page: Public or internal

---

#### Task 3.2: Security Documentation
| Attribute | Details |
|-----------|---------|
| **ID** | W3-T2 |
| **Description** | Document security procedures and configurations |
| **Effort** | 1 hour |
| **Owner** | Security Team |
| **Priority** | 🟡 Medium |
| **Dependencies** | W1 and W2 tasks complete |
| **Acceptance Criteria** | Security runbook created |

**Documentation:**
- Security headers configuration
- Plugin inventory
- Backup procedures
- Incident response contacts
- 2FA recovery procedures

---

### Phase 4: Week 4 - Validation (1.5 hours)

#### Task 4.1: Testing & Validation
| Attribute | Details |
|-----------|---------|
| **ID** | W4-T1 |
| **Description** | Test all security controls and validate implementation |
| **Effort** | 1 hour |
| **Owner** | Security Team |
| **Priority** | 🔴 High |
| **Dependencies** | All W1-W3 tasks complete |
| **Acceptance Criteria** | All controls tested and verified |

**Validation Checklist:**
```
□ Security headers present (8/8)
□ REST API user enumeration blocked
□ 2FA enforced for all admins
□ All plugins updated
□ Wordfence WAF active
□ Daily backups running
□ Uptime monitoring active
□ Documentation complete
```

---

#### Task 4.2: Re-Audit Preparation
| Attribute | Details |
|-----------|---------|
| **ID** | W4-T2 |
| **Description** | Prepare for 30-day re-audit |
| **Effort** | 30 minutes |
| **Owner** | Security Team |
| **Priority** | 🟡 Medium |
| **Dependencies** | W4-T1 complete |
| **Acceptance Criteria** | Re-audit scheduled for May 10, 2026 |

---

## 📊 Resource Allocation

### Team Roles & Responsibilities

| Role | Name | Responsibilities | Time Commitment |
|------|------|------------------|-----------------|
| **Project Sponsor** | Wulfrano Moreno | Approvals, escalations | 1 hour |
| **Project Manager** | Senior PM Agent | Planning, tracking, reporting | 3 hours |
| **Dev Team Lead** | [TBD] | W1-T1, W1-T2, W1-T4 | 3.5 hours |
| **IT Admin** | [TBD] | W1-T3, W2-T2 | 1.5 hours |
| **Security Team** | [TBD] | W2-T1, W3-T2, W4-T1 | 2.5 hours |
| **TOTAL** | | | **10.5 hours** |

---

## ⚠️ Risk Management

### Risk Register

| ID | Risk | Probability | Impact | Mitigation | Owner |
|----|------|-------------|--------|------------|-------|
| R1 | Plugin breaks site after update | Medium | High | Test in staging first, backup before updates | Dev Team |
| R2 | 2FA locks out admin accounts | Low | High | Generate backup codes, test before enforcing | IT Admin |
| R3 | Security headers break functionality | Low | Medium | Test headers in report-only mode first | Dev Team |
| R4 | Backup restoration fails | Medium | Critical | Test restoration before relying on backups | IT Admin |
| R5 | Timeline slippage | Medium | Low | Buffer time in schedule, prioritize critical fixes | PM |

### Contingency Plans

**R1 Contingency:**
- Maintain backup of previous plugin versions
- Quick rollback procedure documented
- Staging environment for testing

**R2 Contingency:**
- Generate backup codes before enforcement
- Store codes securely offline
- Emergency admin access procedure

**R3 Contingency:**
- Use Content-Security-Policy-Report-Only initially
- Gradual header implementation
- Monitor error logs for issues

---

## 📈 Success Metrics

### Week 1 Metrics (Critical Fixes)

| Metric | Baseline | Target | Status |
|--------|----------|--------|--------|
| Security headers | 0-1/8 | 8/8 | 🟡 In Progress |
| REST API protected | ❌ No | ✅ Yes | 🟡 In Progress |
| 2FA coverage | ⚠️ Unknown | 100% | 🟡 In Progress |
| Plugin updates | ⚠️ Unknown | All current | 🟡 In Progress |

### Month 1 Metrics (Full Project)

| Metric | Baseline | Target | Status |
|--------|----------|--------|--------|
| Overall security rating | B- (6.5/10) | A- (9/10) | 🟡 In Progress |
| OWASP compliance | 50% | 90% | 🟡 In Progress |
| Backup frequency | ⚠️ Unknown | Daily | 🟡 In Progress |
| Uptime monitoring | ❌ None | Active | 🟡 In Progress |

---

## 📊 Communication Plan

### Stakeholder Updates

| Audience | Channel | Frequency | Owner |
|----------|---------|-----------|-------|
| Project Sponsor | Email/Telegram | Weekly summary | PM |
| Dev Team | Slack/Standup | Daily during W1 | Dev Lead |
| IT Admin | Email | As needed | PM |
| Security Team | Slack | Weekly | Security Lead |

### Status Report Template

```
PROJECT STATUS REPORT - Week [N]
Date: [YYYY-MM-DD]
Project: Dual Domain Security Hardening

OVERALL STATUS: 🟢 On Track / 🟡 At Risk / 🔴 Behind

COMPLETED THIS WEEK:
- [Task ID]: [Task Name]
- [Task ID]: [Task Name]

IN PROGRESS:
- [Task ID]: [Task Name] ([Percentage]% complete)

BLOCKERS/ISSUES:
- [Issue description] - [Mitigation]

NEXT WEEK PRIORITIES:
- [Task ID]: [Task Name]
- [Task ID]: [Task Name]

METRICS:
- Security headers: [X]/8
- 2FA coverage: [X]%
- Plugin updates: [X]/[Total]

BUDGET:
- Planned: [X] hours
- Actual: [X] hours
- Variance: [+/-X] hours
```

---

## 🎯 Critical Path

```
W1-T1 (Security Headers) ─┬─> W2-T1 (Wordfence) ─> W4-T1 (Validation)
                          │
W1-T2 (REST API) ─────────┤
                          │
W1-T3 (2FA) ──────────────┤
                          │
W1-T4 (Plugin Audit) ─────┘

W2-T2 (Backups) ──────────────────────────────> W4-T1 (Validation)

W3-T1 (Monitoring) ───────────────────────────> W4-T1 (Validation)

W3-T2 (Documentation) ────────────────────────> W4-T2 (Re-Audit)
```

**Critical Path Duration:** 4 weeks  
**Buffer:** 3 days built into Week 4

---

## 📅 Milestone Schedule

| Milestone | Date | Deliverable | Acceptance Criteria |
|-----------|------|-------------|---------------------|
| **M1: Critical Fixes Complete** | Apr 17 | W1-T1 to W1-T4 done | All 4 tasks verified |
| **M2: Hardening Complete** | Apr 24 | W2-T1, W2-T2 done | Wordfence + Backups active |
| **M3: Monitoring Active** | May 1 | W3-T1, W3-T2 done | Monitoring + Docs complete |
| **M4: Validation Complete** | May 10 | W4-T1, W4-T2 done | Re-audit scheduled |

---

## 💰 Budget & Cost

### Effort Estimate

| Phase | Planned Hours | Actual Hours | Variance |
|-------|---------------|--------------|----------|
| Week 1: Critical Fixes | 4.5 | TBD | TBD |
| Week 2: Hardening | 3.0 | TBD | TBD |
| Week 3: Monitoring | 1.5 | TBD | TBD |
| Week 4: Validation | 1.5 | TBD | TBD |
| **TOTAL** | **10.5** | **TBD** | **TBD** |

### Cost Savings (Coordinated Approach)

| Approach | Effort | Savings |
|----------|--------|---------|
| Coordinated (both domains) | 10.5 hours | Baseline |
| Separate (each domain) | 21 hours | -10.5 hours (50% waste) |
| **Savings** | **10.5 hours** | **50%** |

---

## 📞 Escalation Path

| Issue Level | Contact | Response Time |
|-------------|---------|---------------|
| **Level 1: Task Blocker** | Dev Team Lead | 4 hours |
| **Level 2: Timeline Risk** | Project Manager | 24 hours |
| **Level 3: Budget Overrun** | Project Sponsor | 48 hours |
| **Level 4: Security Incident** | Security Team + Sponsor | Immediate |

---

## 🎯 Lessons Learned (To Be Completed Post-Project)

| Category | Lesson | Action |
|----------|--------|--------|
| **What Went Well** | [TBD] | [TBD] |
| **What Could Improve** | [TBD] | [TBD] |
| **Surprises** | [TBD] | [TBD] |
| **Recommendations** | [TBD] | [TBD] |

**Post-Mortem Scheduled:** May 10, 2026 (after re-audit)

---

**Prepared By:** Senior Project Manager Agent  
**Date:** 2026-04-10  
**Next Review:** Weekly status update (April 17, 2026)  
**Re-Audit:** May 10, 2026  
**Classification:** Internal Use Only
