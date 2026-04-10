# Threat Model: www.mexbalia.com

**Date:** 2026-04-10  
**Author:** Security Engineer  
**Version:** 1.0  
**Classification:** Internal Use Only

---

## System Overview

| Attribute | Details |
|-----------|---------|
| **Domain** | www.mexbalia.com (redirects to mexbalia.com) |
| **CMS** | WordPress (version TBD) |
| **Language** | PHP 8.4.19 |
| **Web Server** | Apache |
| **CDN/WAF** | Cloudflare |
| **Hosting** | TBD (requires further recon) |
| **Data Classification** | Business website (public content, potential customer data) |

---

## Trust Boundaries

| Boundary | From | To | Controls |
|----------|------|----|----------|
| Internet → CDN | End user | Cloudflare | DDoS protection, WAF |
| CDN → Origin | Cloudflare | Apache server | HTTPS, origin pull |
| Web → Application | Apache | WordPress PHP | File permissions |
| Application → Database | WordPress PHP | MySQL/MariaDB | Credentials in wp-config.php |
| Admin → Dashboard | Admin user | /wp-admin | Authentication required |

---

## STRIDE Threat Analysis

### 1. Spoofing (Identity Attacks)

| Threat | Component | Risk | Attack Scenario | Mitigation |
|--------|-----------|------|-----------------|------------|
| Credential stuffing | /wp-login.php | High | Automated login with leaked credentials | 2FA, rate limiting, Cloudflare WAF |
| Session hijacking | PHP session cookies | Medium | XSS steals session cookie | HttpOnly, Secure, SameSite flags |
| Admin impersonation | /wp-admin | High | Compromised admin account | Strong passwords, 2FA, limited admin accounts |

### 2. Tampering (Data Integrity)

| Threat | Component | Risk | Attack Scenario | Mitigation |
|--------|-----------|------|-----------------|------------|
| Plugin file modification | /wp-content/plugins/ | Critical | Backdoor injection via vulnerable plugin | File integrity monitoring, minimal plugins |
| Database tampering | MySQL database | Critical | SQL injection modifies content | Parameterized queries (WordPress core handles) |
| Content defacement | Public pages | High | Attacker modifies homepage | File permissions, WAF, backups |

### 3. Repudiation (Audit Trail)

| Threat | Component | Risk | Attack Scenario | Mitigation |
|--------|-----------|------|-----------------|------------|
| No audit logging | WordPress logs | Medium | Attacker actions not traceable | Enable WP audit logging, server logs |
| Log deletion | Server logs | Medium | Attacker covers tracks | Remote log shipping, immutable logs |

### 4. Information Disclosure

| Threat | Component | Risk | Attack Scenario | Mitigation |
|--------|-----------|------|-----------------|------------|
| User enumeration | /wp-json/wp/v2/users | Medium | REST API reveals usernames | Disable user enumeration, limit REST API |
| Version disclosure | Generator meta tags | Low | WordPress version exposed | Remove version from head, security through obscurity |
| Directory listing | Apache config | Medium | Sensitive files exposed | Disable directory indexes |
| Error messages | PHP errors | Medium | Stack traces leak paths | Disable display_errors, log only |

### 5. Denial of Service

| Threat | Component | Risk | Attack Scenario | Mitigation |
|--------|-----------|------|-----------------|------------|
| DDoS attack | Network layer | High | Volumetric attack overwhelms server | Cloudflare DDoS protection |
| Application layer DoS | WordPress | Medium | Slowloris, resource exhaustion | Rate limiting, timeouts, caching |
| Brute force | /wp-login.php | High | Credential stuffing exhausts resources | Cloudflare WAF, fail2ban, 2FA |
| XML-RPC amplification | /xmlrpc.php | Medium | DDoS amplification via pingback | Disable XML-RPC if not needed |

### 6. Elevation of Privilege

| Threat | Component | Risk | Attack Scenario | Mitigation |
|--------|-----------|------|-----------------|------------|
| Plugin vulnerability | Third-party plugins | Critical | RCE via vulnerable plugin | Minimal plugins, prompt updates |
| Theme vulnerability | Custom/third-party themes | High | XSS or auth bypass | Audited themes only |
| Misconfiguration | Apache/PHP config | Medium | Privilege escalation via config | Hardened configs, regular audits |
| Database privilege escalation | MySQL user | High | WordPress user gains DB admin | Least privilege DB user |

---

## Attack Surface Map

### Public Endpoints

| Endpoint | Method | Risk | Notes |
|----------|--------|------|-------|
| `/` | GET | Low | Homepage, public content |
| `/wp-admin/` | POST | High | Admin dashboard (auth required) |
| `/wp-login.php` | POST | High | Login endpoint (brute force target) |
| `/wp-json/` | GET | Medium | REST API (user enumeration risk) |
| `/wp-json/wp/v2/*` | GET | Medium | REST API endpoints |
| `/xmlrpc.php` | POST | Medium | XML-RPC (disable if unused) |
| `/wp-content/uploads/` | GET | Medium | File uploads (potential PHP upload) |
| `/wp-content/plugins/` | GET | High | Plugin files (version disclosure) |
| `/wp-content/themes/` | GET | Medium | Theme files (version disclosure) |
| `/wp-includes/` | GET | Low | WordPress core files |

### Hidden/Sensitive Endpoints to Check

| Endpoint | Purpose | Should Be |
|----------|---------|-----------|
| `/wp-config.php` | Database credentials | ❌ Blocked (403) |
| `/.htaccess` | Apache config | ❌ Blocked (403) |
| `/readme.html` | WordPress docs | ❌ Removed or blocked |
| `/wp-install.php` | Installation script | ❌ Removed after install |
| `/.git/` | Version control | ❌ Blocked (shouldn't exist in prod) |
| `/backup/` | Backup files | ❌ Blocked or removed |

---

## Vulnerability Assessment Plan

### Phase 1: Passive (Completed)

- [x] HTTP headers analysis
- [x] Technology stack identification
- [x] Security headers gap analysis

### Phase 2: Active Scanning (Next)

| Tool | Command | Purpose | Rate Limit |
|------|---------|---------|------------|
| **WPScan** | `wpscan --url https://mexbalia.com --enumerate vp,vt,u` | WordPress vuln scan | 10 req/s |
| **Nikto** | `nikto -h https://mexbalia.com -rate 1` | Web vuln scanner | 1 req/s |
| **Nmap** | `nmap -sV -sC --max-rate 100 mexbalia.com` | Port/service scan | 100 pkt/s |
| **Gobuster** | `gobuster dir -u https://mexbalia.com -t 10` | Directory enum | 10 threads |

### Phase 3: Manual Testing

| Test | Method | Risk |
|------|--------|------|
| SQL Injection | Manual probing of forms | Low (detection only) |
| XSS | Manual payload testing | Low (non-persistent only) |
| CSRF | Form token analysis | None (passive) |
| Authentication | Login flow review | None (passive) |
| Authorization | Role-based access check | None (passive) |

---

## Risk Prioritization

### Critical (Fix Within 24 Hours)

| Risk | Evidence | Remediation |
|------|----------|-------------|
| Vulnerable plugins | Pending WPScan | Update or remove vulnerable plugins |
| Missing security headers | Headers analysis | Install security headers plugin |
| Exposed wp-config.php | Pending scan | Block direct access via .htaccess |

### High (Fix Within 1 Week)

| Risk | Evidence | Remediation |
|------|----------|-------------|
| User enumeration | REST API exposed | Disable via functions.php or plugin |
| XML-RPC enabled | Pending verification | Disable if not needed |
| No 2FA on admin | Industry standard | Enable 2FA for all admins |

### Medium (Fix Within 1 Month)

| Risk | Evidence | Remediation |
|------|----------|-------------|
| Missing audit logging | STRIDE analysis | Install audit logging plugin |
| No file integrity monitoring | STRIDE analysis | Install Wordfence or similar |
| Infrequent backups | Industry standard | Daily automated backups |

---

## Security Controls Matrix

| Control | Status | Priority | Owner |
|---------|--------|----------|-------|
| **WAF (Cloudflare)** | ✅ Active | Maintained | Ops |
| **HTTPS/TLS** | ✅ Active | Maintained | Ops |
| **Security Headers** | ❌ Missing | High | Dev |
| **2FA for Admins** | ⚠️ Unknown | High | Admin |
| **Automatic Updates** | ⚠️ Unknown | Medium | Ops |
| **Daily Backups** | ⚠️ Unknown | High | Ops |
| **Malware Scanning** | ⚠️ Unknown | Medium | Ops |
| **Audit Logging** | ❌ Missing | Medium | Dev |
| **File Integrity Monitoring** | ❌ Missing | Medium | Ops |
| **Rate Limiting** | ⚠️ Partial (Cloudflare) | Medium | Ops |

---

## Recommended Next Steps

### Immediate (Today)

1. **Run WPScan** - Identify plugin/theme vulnerabilities
2. **Check security headers** - Verify what's missing
3. **Audit admin accounts** - Remove unused, enforce 2FA
4. **Review active plugins** - Remove unused, update all

### This Week

1. **Install security plugin** - Wordfence or Sucuri
2. **Configure security headers** - Via plugin or .htaccess
3. **Disable XML-RPC** - If not needed for integrations
4. **Restrict REST API** - Limit user enumeration

### This Month

1. **Set up monitoring** - Uptime, vulnerability alerts
2. **Implement daily backups** - Automated, offsite
3. **Security audit** - Full penetration test
4. **Incident response plan** - Document and test

---

## Tools & Commands

### WPScan (WordPress Security Scanner)

```bash
# Full scan with vulnerability enumeration
wpscan --url https://mexbalia.com \
  --enumerate vp,vt,u,m \
  --api-token YOUR_TOKEN \
  -o scans/wpscan-full.txt

# Plugin enumeration only
wpscan --url https://mexbalia.com --enumerate p -o scans/wpscan-plugins.txt

# User enumeration (for testing)
wpscan --url https://mexbalia.com --enumerate u -o scans/wpscan-users.txt
```

### Nikto (Web Vulnerability Scanner)

```bash
# Rate-limited scan (1 req/sec)
nikto -h https://mexbalia.com -rate 1 -timeout 10 -o scans/nikto-mexbalia.txt

# SSL/TLS assessment
nikto -h https://mexbalia.com -ssl -o scans/nikto-ssl.txt
```

### Nmap (Network Scanner)

```bash
# Conservative scan (rate-limited)
nmap -sV -sC -T3 --max-rate 100 -oA scans/nmap-mexbalia mexbalia.com

# Full port scan (slower)
nmap -p- -sV -T3 --max-rate 50 -oA scans/nmap-full mexbalia.com
```

---

**Author:** Security Engineer  
**Date:** 2026-04-10  
**Next Review:** After active scanning phase  
**Status:** Draft (pending WPScan results)
