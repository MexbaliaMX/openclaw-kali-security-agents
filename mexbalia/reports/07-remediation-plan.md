# Remediation Plan: www.mexbalia.com

**Date:** 2026-04-10  
**Priority:** Critical Fixes First  
**Estimated Total Effort:** 11.5 hours (Week 1-4)

---

## 🚀 Week 1: Critical Fixes (MUST DO)

### Task 1: Install Security Headers Plugin

| Detail | Value |
|--------|-------|
| **Priority** | 🔴 Critical |
| **Effort** | 30 minutes |
| **Impact** | High (prevents XSS, clickjacking, MIME-sniffing) |
| **Owner** | Dev Team |
| **Due** | April 11, 2026 |

**Steps:**
1. Login to WordPress admin
2. Navigate to Plugins → Add New
3. Search for "Security Headers" or "HTTP Headers"
4. Install and activate (recommended: "HTTP Headers" plugin)
5. Configure headers:
   - Strict-Transport-Security: `max-age=31536000; includeSubDomains`
   - X-Content-Type-Options: `nosniff`
   - X-Frame-Options: `SAMEORIGIN`
   - X-XSS-Protection: `1; mode=block`
   - Referrer-Policy: `strict-origin-when-cross-origin`
   - Content-Security-Policy: Start with report-only mode
6. Test site functionality
7. Verify headers with: `curl -I https://mexbalia.com`

**Verification:**
```bash
curl -I https://mexbalia.com | grep -E "strict-transport-security|content-security-policy|x-frame-options|x-content-type-options|x-xss-protection|referrer-policy"
```

**Expected Output:** All 7 headers should be present.

---

### Task 2: Disable REST API User Enumeration

| Detail | Value |
|--------|-------|
| **Priority** | 🔴 High |
| **Effort** | 15 minutes |
| **Impact** | Medium (prevents credential stuffing) |
| **Owner** | Dev Team |
| **Due** | April 12, 2026 |

**Option A: Via Functions.php**

1. Access theme's functions.php (via SFTP or file manager)
2. Add following code:
```php
// Disable REST API user endpoint
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
3. Save and test

**Option B: Via Security Plugin**

1. If using Wordfence/Sucuri, enable "Disable REST API for users" option
2. Save settings
3. Test endpoint returns 401/403

**Verification:**
```bash
curl https://mexbalia.com/wp-json/wp/v2/users
```

**Expected Output:** `{"code":"rest_forbidden","message":"...","data":{"status":403}}`

---

### Task 3: Enable 2FA for All Admin Accounts

| Detail | Value |
|--------|-------|
| **Priority** | 🔴 High |
| **Effort** | 30 minutes |
| **Impact** | High (prevents account takeover) |
| **Owner** | Admin/Dev Team |
| **Due** | April 13, 2026 |

**Steps:**
1. Install 2FA plugin (recommended: "WP 2FA" or "Google Authenticator")
2. Navigate to Users → All Users
3. For each admin user:
   - Install authenticator app (Google Authenticator, Authy) on phone
   - Scan QR code from WordPress
   - Enter verification code
   - Save backup codes in secure location
4. Enforce 2FA policy:
   - Go to WP 2FA → Policy
   - Enable "Enforce two-factor authentication"
   - Select roles: Administrator, Editor
   - Set grace period: 7 days
5. Test login with 2FA

**Verification:**
- All admin accounts show "2FA enabled" in user profile
- Login requires verification code

---

### Task 4: Plugin Audit & Updates

| Detail | Value |
|--------|-------|
| **Priority** | 🟠 High |
| **Effort** | 1-2 hours |
| **Impact** | High (closes known vulnerabilities) |
| **Owner** | Dev Team |
| **Due** | April 14, 2026 |

**Steps:**
1. Navigate to Plugins → Installed Plugins
2. Create inventory:
   - Plugin name
   - Current version
   - Latest version
   - Last updated date
   - Active/Inactive status
3. For each plugin:
   - Check if update available → Update immediately
   - Check if inactive → Consider removal
   - Check if no updates in 6+ months → Research alternatives
4. Remove unused plugins:
   - Deactivate
   - Delete (removes files and DB tables)
5. Install vulnerability scanner (WPScan CLI or Wordfence)
6. Run scan:
```bash
wpscan --url https://mexbalia.com --enumerate vp --api-token YOUR_TOKEN
```
7. Address any vulnerable plugins immediately

**Deliverable:** Plugin inventory spreadsheet with status

---

### Task 5: Hide X-Powered-By Header

| Detail | Value |
|--------|-------|
| **Priority** | 🟡 Medium |
| **Effort** | 10 minutes |
| **Impact** | Low (reduces information disclosure) |
| **Owner** | Dev Team |
| **Due** | April 14, 2026 |

**Option A: Via .htaccess**

1. Edit .htaccess in site root
2. Add:
```apache
Header unset X-Powered-By
```
3. Save and test

**Option B: Via PHP.ini**

1. Edit php.ini (or user.ini)
2. Set:
```ini
expose_php = Off
```
3. Restart Apache/PHP-FPM

**Verification:**
```bash
curl -I https://mexbalia.com | grep "x-powered-by"
```

**Expected Output:** No output (header removed)

---

## 🛡️ Week 2-4: Hardening (SHOULD DO)

### Task 6: Install Comprehensive Security Plugin

| Detail | Value |
|--------|-------|
| **Priority** | 🟠 Medium |
| **Effort** | 1 hour |
| **Impact** | High (WAF, malware scanning, login protection) |
| **Owner** | Dev Team |
| **Due** | April 21, 2026 |

**Recommended:** Wordfence Security (free) or Sucuri Security

**Steps:**
1. Install Wordfence Security plugin
2. Run initial scan
3. Configure:
   - Firewall: Enable and optimize
   - Login Security: Enable 2FA, limit login attempts
   - Scan Schedule: Daily
   - Real-time Protection: Enable (premium feature)
4. Review and address scan findings
5. Configure email alerts for critical issues

---

### Task 7: Configure Daily Backups

| Detail | Value |
|--------|-------|
| **Priority** | 🔴 High |
| **Effort** | 1 hour |
| **Impact** | Critical (disaster recovery) |
| **Owner** | Ops Team |
| **Due** | April 21, 2026 |

**Recommended:** UpdraftPlus or BlogVault

**Steps:**
1. Install UpdraftPlus plugin
2. Configure backup schedule:
   - Files: Daily
   - Database: Hourly (if possible) or Daily
3. Configure remote storage:
   - Google Drive, Dropbox, or S3
   - Do NOT store backups on same server
4. Set retention:
   - Keep last 14 daily backups
   - Keep last 4 weekly backups
5. Test restoration:
   - Create test site
   - Restore from backup
   - Verify site functionality

**Verification:**
- Daily backup emails received
- Backup files visible in remote storage
- Restoration test successful

---

### Task 8: Set Up Monitoring & Alerts

| Detail | Value |
|--------|-------|
| **Priority** | 🟡 Medium |
| **Effort** | 1 hour |
| **Impact** | Medium (early warning system) |
| **Owner** | Ops Team |
| **Due** | April 28, 2026 |

**Uptime Monitoring:**
1. Create account at Uptime Robot (free: 50 monitors)
2. Add monitor:
   - URL: https://mexbalia.com
   - Check interval: 5 minutes
   - Alert contacts: Email, SMS
3. Configure alert thresholds:
   - Down for 5 minutes: Email alert
   - Down for 15 minutes: SMS alert

**Vulnerability Monitoring:**
1. Create WPScan account (free: 25 scans/day)
2. Schedule weekly scans
3. Configure email alerts for new vulnerabilities

**Security Alerts:**
1. In Wordfence/Sucuri:
   - Enable email alerts for:
     - Login failures (>5 attempts)
     - Plugin/theme changes
     - File modifications
     - Malware detected

---

## 📊 Week 4: Validation (NICE TO DO)

### Task 9: Re-Scan and Validate

| Detail | Value |
|--------|-------|
| **Priority** | 🟡 Medium |
| **Effort** | 1 hour |
| **Impact** | High (confirms fixes applied) |
| **Owner** | Security Team |
| **Due** | May 10, 2026 |

**Steps:**
1. Run full security scan:
```bash
wpscan --url https://mexbalia.com --enumerate vp,vt,u --api-token YOUR_TOKEN
```
2. Verify security headers:
```bash
curl -I https://mexbalia.com | grep -E "strict-transport-security|content-security-policy|x-frame-options|x-content-type-options|x-xss-protection|referrer-policy"
```
3. Test REST API user endpoint:
```bash
curl https://mexbalia.com/wp-json/wp/v2/users
```
4. Verify 2FA enabled for all admins
5. Review backup logs (confirm daily backups)
6. Review monitoring alerts (confirm active)

**Deliverable:** Validation report showing all fixes applied

---

### Task 10: Document Security Procedures

| Detail | Value |
|--------|-------|
| **Priority** | 🟡 Medium |
| **Effort** | 2 hours |
| **Impact** | Medium (knowledge retention) |
| **Owner** | Security Team |
| **Due** | May 10, 2026 |

**Documents to Create:**

1. **Security Policy** (1-2 pages)
   - Password requirements
   - 2FA requirements
   - Plugin update policy
   - Backup policy

2. **Incident Response Plan** (2-3 pages)
   - Who to contact for security incidents
   - Steps to contain breach
   - Communication plan
   - Recovery procedures

3. **Monthly Security Checklist** (1 page)
   - Plugin audit
   - Backup verification
   - Log review
   - Vulnerability scan

**Deliverable:** Security documentation folder

---

## 📈 Progress Tracking

### Week 1 Checklist

```
[ ] Task 1: Security headers plugin installed
[ ] Task 2: REST API user enumeration disabled
[ ] Task 3: 2FA enabled for all admins
[ ] Task 4: Plugin audit complete, all updated
[ ] Task 5: X-Powered-By header removed
```

### Week 2-4 Checklist

```
[ ] Task 6: Wordfence/Sucuri installed and configured
[ ] Task 7: Daily backups configured and tested
[ ] Task 8: Monitoring and alerts active
[ ] Task 9: Re-scan complete, all fixes validated
[ ] Task 10: Security procedures documented
```

---

## 🎯 Success Criteria

### Week 1 (Critical)

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Security Headers | 1/8 | 8/8 | 🟡 Pending |
| 2FA for Admins | Unknown | 100% | 🟡 Pending |
| Plugin Updates | Unknown | All current | 🟡 Pending |
| User Enumeration | Enabled | Disabled | 🟡 Pending |

### Month 1 (Full Remediation)

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Overall Security Score | B- (6.5/10) | A- (9/10) | 🟡 Pending |
| OWASP Compliance | 50% | 90% | 🟡 Pending |
| Backup Frequency | Unknown | Daily | 🟡 Pending |
| Monitoring Active | No | Yes | 🟡 Pending |

---

## 📞 Support & Escalation

### Technical Questions

- **Security Headers:** Dev Team Lead
- **Plugin Issues:** WordPress Developer
- **Backup/Monitoring:** Ops Team

### Escalation Path

1. **Blockers:** Project Manager (immediate)
2. **Budget Issues:** Project Sponsor (within 24 hours)
3. **Security Incidents:** CTO/Security Lead (immediate)

---

**Plan Created:** 2026-04-10  
**Week 1 Deadline:** 2026-04-17  
**Full Remediation Deadline:** 2026-05-10  
**Re-Assessment Date:** 2026-05-10

---

*This remediation plan is actionable. Each task includes step-by-step instructions and verification commands.*
