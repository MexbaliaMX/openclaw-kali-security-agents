# Security Implementation Checklists

**Project:** Dual Domain Security Hardening  
**Domains:** mexbalia.com + mexbalia.mx  
**Created:** 2026-04-10  
**Version:** 1.0

---

## 📋 Master Checklist Overview

| Week | Focus | Tasks | Status |
|------|-------|-------|--------|
| **Week 1** | Critical Fixes | 4 tasks | ⏳ Not Started |
| **Week 2** | Hardening | 2 tasks | ⏳ Not Started |
| **Week 3** | Monitoring | 2 tasks | ⏳ Not Started |
| **Week 4** | Validation | 2 tasks | ⏳ Not Started |

---

## 🔴 WEEK 1: Critical Fixes (April 10-17)

### Task 1.1: Security Headers Plugin

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 30 minutes  
**Owner:** Dev Team  
**Priority:** 🔴 Critical

#### Pre-Installation
- [ ] Backup current site (files + database)
- [ ] Document current headers (baseline)
- [ ] Verify admin access to both WordPress installations
- [ ] Create rollback plan

#### Installation (mexbalia.com)
- [ ] Login to WordPress admin (mexbalia.com)
- [ ] Navigate to Plugins → Add New
- [ ] Search for "HTTP Headers" or "Security Headers"
- [ ] Install plugin (recommended: "HTTP Headers" by Fakhri)
- [ ] Activate plugin
- [ ] Navigate to Settings → HTTP Headers

#### Configuration (mexbalia.com)
- [ ] Enable Strict-Transport-Security
  - Value: `max-age=31536000; includeSubDomains`
- [ ] Enable X-Content-Type-Options
  - Value: `nosniff`
- [ ] Enable X-Frame-Options
  - Value: `SAMEORIGIN`
- [ ] Enable X-XSS-Protection
  - Value: `1; mode=block`
- [ ] Enable Referrer-Policy
  - Value: `strict-origin-when-cross-origin`
- [ ] Enable Content-Security-Policy
  - Value: `default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:; frame-ancestors 'self';`
- [ ] Enable Permissions-Policy
  - Value: `geolocation=(), microphone=(), camera=()`
- [ ] Save configuration

#### Verification (mexbalia.com)
```bash
# Run these commands and verify all headers present
curl -I https://mexbalia.com 2>&1 | grep -i "strict-transport-security"
curl -I https://mexbalia.com 2>&1 | grep -i "content-security-policy"
curl -I https://mexbalia.com 2>&1 | grep -i "x-frame-options"
curl -I https://mexbalia.com 2>&1 | grep -i "x-content-type-options"
curl -I https://mexbalia.com 2>&1 | grep -i "x-xss-protection"
curl -I https://mexbalia.com 2>&1 | grep -i "referrer-policy"
curl -I https://mexbalia.com 2>&1 | grep -i "permissions-policy"
```
- [ ] All 8 headers present
- [ ] No errors in browser console
- [ ] Site functionality not broken

#### Repeat for mexbalia.mx
- [ ] Login to WordPress admin (mexbalia.mx)
- [ ] Install same plugin
- [ ] Configure same 8 headers
- [ ] Verify with curl commands
- [ ] All 8 headers present

#### Documentation
- [ ] Screenshot header configuration (both domains)
- [ ] Save curl verification output
- [ ] Update plugin inventory document
- [ ] Note any issues or deviations

#### Rollback Plan (if needed)
- [ ] Document how to disable plugin
- [ ] Keep backup of original .htaccess
- [ ] Test site restoration procedure

---

### Task 1.2: REST API Protection

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 15 minutes  
**Owner:** Dev Team  
**Priority:** 🔴 High

#### Pre-Implementation
- [ ] Backup functions.php (both domains)
- [ ] Document current REST API behavior
- [ ] Identify active theme (both domains)

#### Implementation (mexbalia.com)
- [ ] Access theme's functions.php via SFTP or file manager
- [ ] Locate end of functions.php file
- [ ] Add following code:

```php
/**
 * Disable REST API user enumeration
 * Prevents credential stuffing attacks
 * Added: 2026-04-10
 */
add_filter('rest_endpoints', function($endpoints) {
    // Remove user enumeration endpoints
    if (isset($endpoints['/wp/v2/users'])) {
        unset($endpoints['/wp/v2/users']);
    }
    if (isset($endpoints['/wp/v2/users/(?P<id>[\d]+)'])) {
        unset($endpoints['/wp/v2/users/(?P<id>[\d]+)']);
    }
    return $endpoints;
});
```

- [ ] Save functions.php
- [ ] Clear any caching (plugin, CDN, browser)

#### Verification (mexbalia.com)
```bash
# Test user enumeration endpoint - should return 403
curl https://mexbalia.com/wp-json/wp/v2/users

# Expected response:
# {"code":"rest_forbidden","message":"...","data":{"status":403}}
```
- [ ] Endpoint returns 403 Forbidden
- [ ] Error code: "rest_forbidden"
- [ ] Legitimate API functions still work (test pages endpoint)

```bash
# Verify legitimate API still works
curl https://mexbalia.com/wp-json/wp/v2/pages
# Should return 200 OK with page list
```
- [ ] Pages endpoint returns 200 OK
- [ ] Site functionality not broken

#### Repeat for mexbalia.mx
- [ ] Access functions.php (mexbalia.mx)
- [ ] Add same code
- [ ] Save file
- [ ] Clear cache
- [ ] Test returns 403
- [ ] Verify legitimate API works

#### Documentation
- [ ] Document code added to functions.php
- [ ] Save curl test output (before/after)
- [ ] Note theme name and file location
- [ ] Update security configuration document

---

### Task 1.3: 2FA Enforcement

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 30 minutes  
**Owner:** IT Admin  
**Priority:** 🔴 High

#### Pre-Implementation
- [ ] Inventory all admin accounts (both domains)
- [ ] Install authenticator app on phone (Google Authenticator, Authy, etc.)
- [ ] Prepare secure storage for backup codes
- [ ] Notify admin users of upcoming 2FA requirement

#### Installation (mexbalia.com)
- [ ] Login to WordPress admin (mexbalia.com)
- [ ] Navigate to Plugins → Add New
- [ ] Search for "WP 2FA"
- [ ] Install "WP 2FA - Two-Factor Authentication" plugin
- [ ] Activate plugin

#### Configuration (mexbalia.com)
- [ ] Navigate to WP 2FA → 2FA Policies
- [ ] Enable "Enforce two-factor authentication"
- [ ] Select roles: Administrator
- [ ] Set grace period: 7 days
- [ ] Enable "Allow users to remember this device"
- [ ] Set remember period: 30 days
- [ ] Save policy

#### Enable 2FA for Each Admin (mexbalia.com)
For EACH admin account:
- [ ] Login with admin credentials
- [ ] Navigate to Users → Profile
- [ ] Scroll to "Two-Factor Authentication" section
- [ ] Click "Enable Two-Factor Authentication"
- [ ] Scan QR code with authenticator app
- [ ] Enter verification code from app
- [ ] Generate backup codes
- [ ] **Store backup codes securely offline** (password manager, encrypted file, printed copy)
- [ ] Test login with 2FA
- [ ] Mark admin as 2FA-enabled in inventory

```
Admin Inventory - mexbalia.com
| Username | Email | 2FA Enabled | Backup Codes Stored | Date |
|----------|-------|-------------|---------------------|------|
| [admin1] | [...] | □           | □                   |      |
| [admin2] | [...] | □           | □                   |      |
```

#### Repeat for mexbalia.mx
- [ ] Install WP 2FA plugin
- [ ] Configure same policy
- [ ] Enable 2FA for each admin
- [ ] Store backup codes securely
- [ ] Test login flow

#### Verification
- [ ] All admin accounts have 2FA enabled
- [ ] Backup codes stored securely (both domains)
- [ ] Test 2FA login successful
- [ ] Test backup code login successful
- [ ] Test account lockout after failed attempts

#### Documentation
- [ ] Document 2FA plugin configuration
- [ ] List all admin accounts with 2FA status
- [ ] Store backup code location (securely)
- [ ] Document recovery procedure

---

### Task 1.4: Plugin Audit & Updates

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 2 hours  
**Owner:** Dev Team  
**Priority:** 🟠 High

#### Pre-Audit
- [ ] Create plugin inventory template
- [ ] Backup site (both domains)
- [ ] Set up staging environment (if available)

#### Export Plugin List (mexbalia.com)
```bash
# If WP-CLI available:
wp plugin list --format=csv > plugins-mexbalia-com.csv

# Or manually document:
```

```
Plugin Inventory - mexbalia.com
Date: 2026-04-10

| Plugin Name | Version | Status | Last Updated | Action Needed |
|-------------|---------|--------|--------------|---------------|
|             |         | Active |              |               |
```

#### Analyze Each Plugin (mexbalia.com)
For EACH plugin:
- [ ] Check if update available
- [ ] Check last update date
- [ ] Check if actively maintained
- [ ] Check for known vulnerabilities (WPScan, Wordfence)
- [ ] Mark action: Keep/Update/Remove/Replace

#### Update Plugins (mexbalia.com)
- [ ] Update plugins in staging first (if available)
- [ ] Test functionality in staging
- [ ] Update plugins in production
- [ ] One at a time (not bulk update)
- [ ] Test site after each update
- [ ] Document any issues

```
Update Log - mexbalia.com
| Plugin | Old Version | New Version | Date | Tested | Issues |
|--------|-------------|-------------|------|--------|--------|
|        |             |             |      |        |        |
```

#### Remove Inactive Plugins (mexbalia.com)
- [ ] Identify inactive plugins
- [ ] Verify not needed for future
- [ ] Deactivate plugin
- [ ] Delete plugin (removes files and DB tables)
- [ ] Document removal

#### Research Old Plugins (mexbalia.com)
For plugins not updated in 6+ months:
- [ ] Research alternatives
- [ ] Check if still secure to use
- [ ] Plan replacement if needed
- [ ] Document decision

#### Repeat for mexbalia.mx
- [ ] Export plugin list
- [ ] Analyze each plugin
- [ ] Update plugins
- [ ] Remove inactive
- [ ] Research old plugins

#### Final Verification
- [ ] All plugins updated to latest versions
- [ ] No inactive plugins remain
- [ ] No plugins older than 6 months without research
- [ ] Site functionality tested (both domains)
- [ ] No errors in error logs

#### Documentation
- [ ] Final plugin inventory (both domains)
- [ ] Update log with all changes
- [ ] Removal log for deleted plugins
- [ ] Research notes for old plugins
- [ ] Known issues or concerns

---

## 🟠 WEEK 2: Hardening (April 17-24)

### Task 2.1: Security Plugin (Wordfence)

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 1 hour  
**Owner:** Security Team  
**Priority:** 🟠 Medium

#### Installation (mexbalia.com)
- [ ] Login to WordPress admin
- [ ] Navigate to Plugins → Add New
- [ ] Search for "Wordfence Security"
- [ ] Install "Wordfence Security" plugin
- [ ] Activate plugin

#### Configuration (mexbalia.com)
- [ ] Navigate to Wordfence → Dashboard
- [ ] Enter email for alerts
- [ ] Enable Firewall (WAF)
- [ ] Enable Malware Scanner
- [ ] Configure scan schedule: Daily
- [ ] Enable Login Security (rate limiting)
- [ ] Configure email alerts:
  - [ ] Critical problems
  - [ ] Warnings
  - [ ] Login alerts
- [ ] Save configuration

#### Verification (mexbalia.com)
- [ ] WAF status: Enabled
- [ ] Last scan: Shows recent scan
- [ ] No critical issues detected
- [ ] Test alert email received

#### Repeat for mexbalia.mx
- [ ] Install Wordfence
- [ ] Configure same settings
- [ ] Verify enabled
- [ ] Test alerts

#### Documentation
- [ ] Document Wordfence configuration
- [ ] Save alert email addresses
- [ ] Document scan schedule
- [ ] Note any custom rules

---

### Task 2.2: Daily Backups

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 1 hour  
**Owner:** IT Admin  
**Priority:** 🔴 Critical

#### Pre-Configuration
- [ ] Choose backup storage: Google Drive / Dropbox / S3
- [ ] Create backup account (if needed)
- [ ] Verify storage space available
- [ ] Test backup account credentials

#### Installation (mexbalia.com)
- [ ] Login to WordPress admin
- [ ] Navigate to Plugins → Add New
- [ ] Search for "UpdraftPlus"
- [ ] Install "UpdraftPlus WordPress Backup Plugin"
- [ ] Activate plugin

#### Configuration (mexbalia.com)
- [ ] Navigate to Settings → UpdraftPlus Backups
- [ ] Click "Settings" tab
- [ ] Configure backup schedule:
  - Files: Daily
  - Database: Hourly (or Daily if not available)
- [ ] Configure retention:
  - Keep 14 backups
- [ ] Configure remote storage:
  - Select: Google Drive / Dropbox / S3
  - Authenticate and connect
- [ ] Enable encryption (optional but recommended)
- [ ] Save changes

#### Test Backup (mexbalia.com)
- [ ] Click "Backup Now"
- [ ] Select: Include files + database
- [ ] Start backup
- [ ] Wait for completion
- [ ] Verify backup in remote storage
- [ ] Verify backup files present

#### Test Restoration (mexbalia.com) - CRITICAL
- [ ] Document test restoration procedure
- [ ] Create test environment (staging or local)
- [ ] Download backup files
- [ ] Attempt restoration in test environment
- [ ] Verify site functions after restoration
- [ ] Document any issues
- [ ] **Do not skip this step!**

#### Repeat for mexbalia.mx
- [ ] Install UpdraftPlus
- [ ] Configure same schedule
- [ ] Connect remote storage
- [ ] Test backup
- [ ] **Test restoration**

#### Documentation
- [ ] Document backup schedule (both domains)
- [ ] Document storage location
- [ ] Store backup account credentials (securely)
- [ ] Document restoration procedure
- [ ] Save test restoration results

---

## 🟡 WEEK 3: Monitoring (April 24 - May 1)

### Task 3.1: Uptime Monitoring

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 30 minutes  
**Owner:** SecOps  
**Priority:** 🟡 Medium

#### Setup Uptime Robot Account
- [ ] Navigate to uptimerobot.com
- [ ] Create free account
- [ ] Verify email address
- [ ] Configure alert contacts:
  - [ ] Email address
  - [ ] SMS number (optional)

#### Add Monitor (mexbalia.com)
- [ ] Click "Add New Monitor"
- [ ] Monitor type: HTTP(s)
- [ ] Friendly name: mexbalia.com
- [ ] URL: https://mexbalia.com
- [ ] Monitoring interval: 5 minutes
- [ ] Alert contacts: Select configured contacts
- [ ] Advanced settings:
  - [ ] Enable SSL expiry alerts
  - [ ] Enable keyword monitoring (optional)
- [ ] Create monitor

#### Add Monitor (mexbalia.mx)
- [ ] Add second monitor
- [ ] Same configuration
- [ ] Create monitor

#### Verification
- [ ] Both monitors show "Up" status
- [ ] Test alert by simulating downtime (optional)
- [ ] Verify alert email/SMS received
- [ ] Bookmark dashboard URL

#### Documentation
- [ ] Document Uptime Robot account
- [ ] Store login credentials (securely)
- [ ] Document alert contacts
- [ ] Save dashboard URL
- [ ] Document escalation procedure

---

### Task 3.2: Security Documentation

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 1 hour  
**Owner:** Security Team  
**Priority:** 🟡 Medium

#### Create Security Runbook
- [ ] Create document: Security-Runbook.md
- [ ] Document security headers configuration
- [ ] Document REST API protection code
- [ ] Document 2FA configuration
- [ ] Document plugin inventory
- [ ] Document backup procedures
- [ ] Document monitoring setup
- [ ] Document incident response contacts

#### Create Configuration Backup
- [ ] Export Wordfence settings
- [ ] Export UpdraftPlus settings
- [ ] Backup functions.php (both domains)
- [ ] Backup .htaccess (both domains)
- [ ] Store securely

#### Create Recovery Procedures
- [ ] Document site restoration procedure
- [ ] Document backup code recovery
- [ ] Document admin account recovery
- [ ] Document emergency contacts

#### Documentation Review
- [ ] Review all documentation for accuracy
- [ ] Test recovery procedures (if possible)
- [ ] Share with team members
- [ ] Store in secure, accessible location

---

## 🔴 WEEK 4: Validation (May 1-10)

### Task 4.1: Testing & Validation

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 1 hour  
**Owner:** Security Team  
**Priority:** 🔴 High

#### Security Headers Validation
```bash
# Run for both domains
curl -I https://mexbalia.com 2>&1 | grep -iE "strict-transport-security|content-security-policy|x-frame-options|x-content-type-options|x-xss-protection|referrer-policy|permissions-policy"
curl -I https://mexbalia.mx 2>&1 | grep -iE "strict-transport-security|content-security-policy|x-frame-options|x-content-type-options|x-xss-protection|referrer-policy|permissions-policy"
```
- [ ] mexbalia.com: All 8 headers present
- [ ] mexbalia.mx: All 8 headers present

#### REST API Protection Validation
```bash
# Test user enumeration endpoint
curl https://mexbalia.com/wp-json/wp/v2/users
curl https://mexbalia.mx/wp-json/wp/v2/users
```
- [ ] mexbalia.com: Returns 403 Forbidden
- [ ] mexbalia.mx: Returns 403 Forbidden

#### 2FA Validation
- [ ] Verify all admin accounts have 2FA enabled (both domains)
- [ ] Test 2FA login flow
- [ ] Verify backup codes accessible

#### Plugin Validation
- [ ] All plugins updated to latest versions
- [ ] No inactive plugins remain
- [ ] Wordfence active and scanning

#### Backup Validation
- [ ] Daily backups running
- [ ] Backups stored in remote location
- [ ] Test restoration successful

#### Monitoring Validation
- [ ] Uptime monitoring active
- [ ] Alerts configured and tested
- [ ] Dashboard accessible

#### Final Checklist
```
FINAL VALIDATION CHECKLIST
□ Security headers: 8/8 (both domains)
□ REST API: Protected (both domains)
□ 2FA: 100% admin coverage (both domains)
□ Plugins: All updated (both domains)
□ Wordfence: Active (both domains)
□ Backups: Daily, remote (both domains)
□ Monitoring: Active (both domains)
□ Documentation: Complete
□ Recovery procedures: Tested
□ Emergency contacts: Documented
```

---

### Task 4.2: Re-Audit Preparation

**Domain:** mexbalia.com + mexbalia.mx  
**Effort:** 30 minutes  
**Owner:** Security Team  
**Priority:** 🟡 Medium

#### Schedule Re-Audit
- [ ] Schedule date: May 10, 2026
- [ ] Invite stakeholders
- [ ] Prepare re-audit checklist
- [ ] Prepare comparison with baseline

#### Prepare Re-Audit Report
- [ ] Collect before/after metrics
- [ ] Document all changes made
- [ ] Calculate risk reduction
- [ ] Calculate OWASP compliance improvement
- [ ] Prepare executive summary

#### Re-Audit Agenda
- [ ] Review security improvements
- [ ] Validate all fixes implemented
- [ ] Discuss ongoing maintenance
- [ ] Plan next audit cycle
- [ ] Lessons learned session

---

## 📊 Progress Tracking

### Weekly Status Template

```
WEEK [N] STATUS - [Date Range]
Overall Status: 🟢 On Track / 🟡 At Risk / 🔴 Behind

COMPLETED:
□ [Task ID]: [Task Name] - [Date Completed]

IN PROGRESS:
□ [Task ID]: [Task Name] - [X]% complete

BLOCKERS:
- [Blocker description] - [Mitigation]

NEXT WEEK PRIORITIES:
□ [Task ID]: [Task Name]
□ [Task ID]: [Task Name]

METRICS:
- Security headers: [X]/8
- 2FA coverage: [X]%
- Plugin updates: [X]/[Total]
- Backups: [Status]
```

---

## 🎯 Success Criteria

### Week 1 Success
```
□ Security headers: 8/8 on both domains
□ REST API: Returns 403 on both domains
□ 2FA: 100% admin coverage on both domains
□ Plugins: All updated, unused removed
□ Documentation: Changes documented
```

### Month 1 Success (Project Complete)
```
□ All Week 1-3 tasks complete
□ Validation tests passed
□ Security rating: A- (9/10)
□ OWASP compliance: 90%
□ Re-audit scheduled
□ Documentation complete
```

---

**Created:** 2026-04-10  
**Version:** 1.0  
**Next Review:** After Week 1 completion (April 17, 2026)  
**Owner:** Project Manager + Security Team
