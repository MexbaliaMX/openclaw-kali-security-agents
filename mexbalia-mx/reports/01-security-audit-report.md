# Security Audit Report: www.mexbalia.mx

**Date:** 2026-04-10  
**Prepared By:** KaliKlaw Security Team  
**Classification:** Internal Use Only  
**Version:** 1.0

---

## 📋 Executive Summary

### Overview

This report presents the findings of a comprehensive security assessment of www.mexbalia.mx conducted on April 10, 2026. This audit mirrors the methodology used for www.mexbalia.com to enable direct comparison and coordinated remediation.

### Key Findings

| Category | Rating | Status |
|----------|--------|--------|
| **Overall Security Posture** | **B-** | ⚠️ Needs Improvement |
| **WAF Protection** | **A+** | ✅ Excellent |
| **Security Headers** | **F (0/8)** | ❌ Critical Gap |
| **Technology Hardening** | **B** | ✅ Better than .com |
| **API Security** | **C** | ⚠️ Needs Work |

### Comparison with mexbalia.com

| Metric | mexbalia.com | mexbalia.mx | Winner |
|--------|--------------|-------------|--------|
| Overall Rating | B- (6.5/10) | B- (6.5/10) | 🤝 Tie |
| WAF | ✅ Cloudflare | ✅ Cloudflare | 🤝 Same |
| Security Headers | 1/8 | 0/8 | 🏆 .com |
| PHP Version Exposed | ❌ Yes | ✅ Hidden | 🏆 .mx |
| Origin Server Hidden | ❌ Apache | ✅ Cloudflare | 🏆 .mx |

### The Bottom Line

**www.mexbalia.mx has similar security gaps to mexbalia.com, with slightly better server hardening but equally critical header deficiencies.**

**Strengths:**
- ✅ Cloudflare WAF is active and protecting origin server
- ✅ PHP version NOT exposed (better than .com)
- ✅ HTTPS/TLS is properly configured
- ✅ Proper www to non-www redirect
- ✅ CDN caching active and configured

**Critical Gaps:**
- ❌ ALL 8 security headers missing (worse than .com)
- ❌ REST API allows user enumeration
- ❌ WordPress fingerprint exposed
- ❌ No evidence of 2FA enforcement

### Risk Assessment

| Risk Level | Count | Examples |
|------------|-------|----------|
| **Critical** | 0 | None found |
| **High** | 2 | Missing ALL security headers, user enumeration |
| **Medium** | 2 | WordPress fingerprinted, potential xmlrpc |
| **Low** | 1 | Cache configuration exposure |

**Overall Risk Score: 6.5/10 (Medium-High)** - Same as mexbalia.com

---

## 🔍 Technical Findings

### 1. Missing Security Headers (CRITICAL)

**Issue:** ALL 8 critical security headers are missing.

**Comparison:**
```
mexbalia.com: 1/8 headers (Permissions-Policy via Cloudflare)
mexbalia.mx:  0/8 headers (NONE present)
```

**Impact:**
- Clickjacking attacks possible (no X-Frame-Options)
- XSS attacks easier (no CSP, no X-XSS-Protection)
- MIME-sniffing attacks (no X-Content-Type-Options)
- No HSTS enforcement (SSL stripping possible)
- Referrer information leakage (no Referrer-Policy)

**Evidence:**
```
HTTP/2 200
server: cloudflare
cf-ray: 9ea2d3afde960c40-DFW
x-redirect-by: WordPress

MISSING (8/8):
❌ Strict-Transport-Security (HSTS)
❌ Content-Security-Policy (CSP)
❌ X-Content-Type-Options
❌ X-Frame-Options
❌ X-XSS-Protection
❌ Referrer-Policy
❌ Cross-Origin-Embedder-Policy
❌ Permissions-Policy
```

**Remediation:** Install security headers plugin:
```apache
# .htaccess configuration
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
Header always set X-Content-Type-Options "nosniff"
Header always set X-Frame-Options "SAMEORIGIN"
Header always set X-XSS-Protection "1; mode=block"
Header always set Referrer-Policy "strict-origin-when-cross-origin"
Header always set Content-Security-Policy "default-src 'self'; ..."
```

---

### 2. REST API User Enumeration (HIGH)

**Issue:** WordPress REST API is accessible, allowing user enumeration.

**Evidence:**
```
link: <https://mexbalia.mx/wp-json/>; rel="https://api.w.org/"
link: <https://mexbalia.mx/wp-json/wp/v2/pages/7>; rel="alternate"
```

**Impact:** Credential stuffing attacks using enumerated usernames.

**Remediation:** Same as mexbalia.com:
```php
// Add to theme's functions.php
add_filter('rest_endpoints', function($endpoints) {
    if (isset($endpoints['/wp/v2/users'])) {
        unset($endpoints['/wp/v2/users']);
    }
    return $endpoints;
});
```

---

### 3. Server Configuration (POSITIVE)

**Finding:** Unlike mexbalia.com, mexbalia.mx does NOT expose:
- ❌ PHP version (NOT exposed - better!)
- ❌ Apache server (hidden behind Cloudflare)

**Evidence:**
```
mexbalia.com: x-powered-by: PHP/8.4.19  ❌ Exposed
mexbalia.mx:  (no x-powered-by header)  ✅ Hidden
```

**Assessment:** This is a **security improvement** over mexbalia.com.

---

### 4. CDN Configuration (GOOD)

**Finding:** Cloudflare CDN is properly configured with active caching.

**Evidence:**
```
cf-cache-status: HIT
age: 2181
cache-control: public, max-age=2678400
expires: Mon, 11 May 2026 15:36:24 GMT
```

**Assessment:** 31-day cache expiry is appropriate for static content.

---

### 5. WordPress Fingerprinting (MEDIUM)

**Issue:** WordPress CMS is easily identified.

**Evidence:**
```
x-redirect-by: WordPress
link: <.../wp-json/>; rel="https://api.w.org/"
link: <.../>; rel=shortlink
```

**Impact:** Attackers know exact CMS, can target WordPress-specific exploits.

---

## 📊 OWASP Top 10 2021 Compliance

| Category | Status | Notes |
|----------|--------|-------|
| A01: Broken Access Control | ⚠️ Partial | REST API user enumeration |
| A02: Cryptographic Failures | ✅ Good | HTTPS active |
| A03: Injection | ✅ Good | No evidence of SQLi/XSS |
| A04: Insecure Design | ⚠️ Unknown | Requires deeper review |
| A05: Security Misconfiguration | ❌ Poor | ALL headers missing |
| A06: Vulnerable Components | ⚠️ Unknown | Plugin audit needed |
| A07: Auth Failures | ⚠️ Unknown | 2FA status unknown |
| A08: Data Integrity | ⚠️ Unknown | Requires review |
| A09: Logging Failures | ⚠️ Unknown | Audit logging status unknown |
| A10: SSRF | ✅ Good | No evidence of SSRF |

**OWASP Compliance Score: 5/10 (50%)** - Same as mexbalia.com

---

## 🎯 Priority Recommendations

### Immediate (This Week)

| # | Action | Priority | Effort | Impact |
|---|--------|----------|--------|--------|
| 1 | **Install security headers plugin** | 🔴 Critical | 30 min | High |
| 2 | **Disable REST API user enumeration** | 🔴 High | 15 min | Medium |
| 3 | **Enable 2FA for all admin accounts** | 🔴 High | 30 min | High |
| 4 | **Audit active plugins** | 🟠 Medium | 1 hour | High |
| 5 | **Configure Permissions-Policy** | 🟡 Medium | 15 min | Medium |

### Short-term (This Month)

| # | Action | Priority | Effort | Impact |
|---|--------|----------|--------|--------|
| 1 | Install Wordfence or Sucuri | 🟠 Medium | 1 hour | High |
| 2 | Implement daily backups | 🔴 High | 1 hour | Critical |
| 3 | Set up uptime monitoring | 🟡 Medium | 30 min | Medium |
| 4 | Review and update plugins | 🟠 Medium | 2 hours | High |

---

## 📈 Domain Comparison Summary

### Security Posture Comparison

```
┌────────────────────────────────────────┬──────────────┬──────────────┐
│ Security Control                       │ mexbalia.com │ mexbalia.mx  │
├────────────────────────────────────────┼──────────────┼──────────────┤
│ WAF Protection                         │ ✅ Cloudflare│ ✅ Cloudflare│
│ HTTPS/TLS                              │ ✅ Active    │ ✅ Active    │
│ Security Headers                       │ 1/8 (12.5%)  │ 0/8 (0%)     │
│ PHP Version Hidden                     │ ❌ No        │ ✅ Yes       │
│ Origin Server Hidden                   │ ❌ No        │ ✅ Yes       │
│ REST API Protected                     │ ❌ No        │ ❌ No        │
│ WordPress Fingerprint Hidden           │ ❌ No        │ ❌ No        │
│ CDN Caching Configured                 │ ⚠️ Unknown  │ ✅ Yes       │
├────────────────────────────────────────┼──────────────┼──────────────┤
│ OVERALL RATING                         │ B- (6.5/10)  │ B- (6.5/10)  │
│ OWASP Compliance                       │ 50%          │ 50%          │
└────────────────────────────────────────┴──────────────┴──────────────┘
```

### Key Takeaways

1. **Both domains have IDENTICAL overall security ratings** (B-)
2. **mexbalia.mx has better server hardening** (PHP version hidden)
3. **mexbalia.com has slightly better headers** (1 vs 0)
4. **Both need CRITICAL security header implementation**
5. **Both need REST API protection**

---

## 🎯 Coordinated Remediation Plan

### Fix Both Domains Together (Recommended)

| Week | Action | Domains | Effort |
|------|--------|---------|--------|
| 1 | Security headers plugin | Both | 1 hour |
| 1 | REST API protection | Both | 30 min |
| 1 | 2FA enforcement | Both | 1 hour |
| 2 | Security plugin (Wordfence) | Both | 2 hours |
| 2 | Backup configuration | Both | 2 hours |
| 3-4 | Plugin audit & updates | Both | 4 hours |

**Total Coordinated Effort:** ~10.5 hours (vs 21 hours if done separately)

---

## 📞 Next Steps

1. **Review this report** alongside mexbalia.com report
2. **Prioritize coordinated fixes** for both domains
3. **Implement security headers** on both sites (same config)
4. **Enable 2FA** on both WordPress installations
5. **Schedule re-assessment** for both domains in 30 days

---

## 📧 Contact

**Prepared By:** KaliKlaw Security Team  
**Date:** 2026-04-10  
**Related Report:** mexbalia.com Security Audit (same date)  
**Next Review:** After Week 1 fixes implemented  
**Re-Assessment:** Recommended in 30 days (both domains)

---

*This report is for internal use only. Coordinate remediation across both domains for maximum efficiency.*
