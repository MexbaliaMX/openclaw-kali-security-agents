# Security Audit Comparison: mexbalia.com vs mexbalia.mx

**Date:** 2026-04-10  
**Prepared By:** KaliKlaw Security Team  
**Type:** Comparative Security Analysis

---

## 📊 Executive Comparison

| Metric | mexbalia.com | mexbalia.mx | Status |
|--------|--------------|-------------|--------|
| **Overall Rating** | B- (6.5/10) | TBD | - |
| **WAF** | ✅ Cloudflare | ✅ Cloudflare | ✅ Both Protected |
| **HTTPS** | ✅ Active | ✅ Active | ✅ Both Secure |
| **CMS** | WordPress | WordPress | ⚠️ Same Platform |
| **PHP Version** | 8.4.19 (exposed) | TBD | ⚠️ Check Needed |
| **Security Headers** | 1/8 (12.5%) | TBD | ⚠️ Check Needed |
| **REST API** | Exposed | TBD | ⚠️ Check Needed |

---

## 🔍 Initial Reconnaissance Results

### www.mexbalia.com (Previous Audit)

```
HTTP/2 200
x-powered-by: PHP/8.4.19              ⚠️ Version exposed
server: Apache                         ⚠️ Server type exposed
x-redirect-by: WordPress               ⚠️ CMS exposed
link: <.../wp-json/>; rel=...         ⚠️ REST API exposed
```

**Key Findings:**
- 🔴 7/8 security headers missing
- 🔴 REST API user enumeration possible
- 🟡 PHP version exposed
- ✅ Cloudflare WAF active and effective

---

### www.mexbalia.mx (Current Audit)

```
HTTP/2 301 (www → non-www redirect)
location: https://mexbalia.mx/
server: cloudflare                    ✅ Hidden origin
cf-cache-status: HIT                  ✅ CDN caching active
x-redirect-by: WordPress               ⚠️ CMS exposed
link: <.../wp-json/>; rel=...         ⚠️ REST API exposed
```

**Initial Observations:**
- ✅ Proper www to non-www redirect
- ✅ Cloudflare protecting origin server
- ✅ CDN caching active (age: 2181 seconds)
- ⚠️ WordPress fingerprint still visible
- ⚠️ REST API endpoint exposed

---

## 🎯 Audit Methodology (Same as mexbalia.com)

### Phase 1: Passive Reconnaissance ✅
- [x] HTTP headers analysis
- [x] Technology stack identification
- [x] Security headers gap analysis
- [ ] DNS records check

### Phase 2: Active Scanning 🟡
- [ ] WPScan (expect WAF block)
- [ ] Nikto (rate-limited)
- [ ] Directory enumeration

### Phase 3: Analysis 🟡
- [ ] Evidence Collector QA
- [ ] Reality Checker validation

### Phase 4: Reporting 🟡
- [ ] Technical Writer report
- [ ] Compliance Auditor mapping
- [ ] Senior PM executive summary

---

## 📋 Expected Findings (Based on mexbalia.com)

### Likely Similarities

| Finding | Confidence | Reason |
|---------|------------|--------|
| Missing security headers | High | Same WordPress setup |
| REST API exposure | High | Default WordPress config |
| Cloudflare WAF | Confirmed | Both show cf-ray headers |
| WordPress fingerprint | Confirmed | x-redirect-by header |

### Potential Differences

| Finding | mexbalia.com | mexbalia.mx (Expected) |
|---------|--------------|------------------------|
| Origin server hidden | ❌ Apache exposed | ✅ Cloudflare only |
| PHP version exposed | ✅ Yes | ⚠️ Likely hidden |
| Cache configuration | Unknown | ✅ Active (2678400s) |

---

## 🔐 Security Implications

### Shared Risks (Both Domains)

1. **WordPress Common Attack Surface**
   - Both run WordPress → same vulnerability profile
   - Plugin vulnerabilities affect both sites
   - Theme vulnerabilities affect both sites

2. **Credential Reuse Risk**
   - Same admin passwords on both sites = double risk
   - Compromise of one site may lead to other

3. **Cross-Domain Attacks**
   - Shared hosting could allow lateral movement
   - Shared credentials enable cross-site access

### Unique Considerations for .mx Domain

1. **Country-Specific Regulations**
   - Mexican data protection laws may apply
   - Different compliance requirements

2. **Regional Threat Landscape**
   - Latin America-specific attack patterns
   - Spanish-language phishing targeting .mx

---

## 📊 Comparison Matrix (Preliminary)

| Security Control | mexbalia.com | mexbalia.mx | Priority |
|------------------|--------------|-------------|----------|
| **WAF** | ✅ Cloudflare | ✅ Cloudflare | ✅ Good |
| **HTTPS** | ✅ TLS | ✅ TLS | ✅ Good |
| **HSTS** | ❌ Missing | ⚠️ Check | 🔴 High |
| **CSP** | ❌ Missing | ⚠️ Check | 🔴 High |
| **X-Frame-Options** | ❌ Missing | ⚠️ Check | 🔴 High |
| **X-Content-Type-Options** | ❌ Missing | ⚠️ Check | 🔴 High |
| **PHP Version Hidden** | ❌ Exposed | ⚠️ Check | 🟡 Medium |
| **REST API Protected** | ❌ Exposed | ⚠️ Check | 🔴 High |
| **2FA Enforced** | ⚠️ Unknown | ⚠️ Unknown | 🔴 High |
| **Backups** | ⚠️ Unknown | ⚠️ Unknown | 🔴 Critical |

---

## 🎯 Recommended Actions

### Immediate (Both Domains)

| Action | Priority | Effort | Impact |
|--------|----------|--------|--------|
| Install security headers plugin | 🔴 Critical | 30 min | High |
| Disable REST API user enumeration | 🔴 High | 15 min | Medium |
| Enable 2FA for all admins | 🔴 High | 30 min | High |
| Audit plugins on both sites | 🟠 Medium | 2 hours | High |

### Domain-Specific

| Domain | Action | Priority |
|--------|--------|----------|
| **mexbalia.com** | Re-audit after fixes | 🟡 Medium |
| **mexbalia.mx** | Complete full audit | 🔴 High |

---

## 📈 Compliance Comparison

### OWASP Top 10 2021

| Category | mexbalia.com | mexbalia.mx |
|----------|--------------|-------------|
| A01: Broken Access Control | ⚠️ Partial | ⏳ Pending |
| A02: Cryptographic Failures | ✅ Good | ⏳ Pending |
| A03: Injection | ✅ Good | ⏳ Pending |
| A05: Security Misconfiguration | ❌ Poor | ⏳ Pending |
| A07: Auth Failures | ⚠️ Unknown | ⏳ Pending |

**mexbalia.com Score:** 5/10 (50%)  
**mexbalia.mx Score:** TBD

---

## 📅 Audit Timeline

| Phase | mexbalia.com | mexbalia.mx |
|-------|--------------|-------------|
| **Passive Recon** | ✅ Complete | ✅ In Progress |
| **Active Scanning** | ✅ Complete | ⏳ Pending |
| **Analysis** | ✅ Complete | ⏳ Pending |
| **Reporting** | ✅ Complete | ⏳ Pending |
| **Remediation** | ⏳ Pending | ⏳ Pending |
| **Re-Audit** | ⏳ Scheduled | ⏳ TBD |

---

## 📝 Next Steps

1. **Complete mexbalia.mx reconnaissance** (current phase)
2. **Compare security headers** between domains
3. **Test REST API exposure** on .mx domain
4. **Generate comparative report** with side-by-side findings
5. **Prioritize fixes** that benefit both domains
6. **Schedule coordinated remediation**

---

**Prepared By:** KaliKlaw Security Team  
**Date:** 2026-04-10  
**Status:** mexbalia.com audit complete, mexbalia.mx audit in progress
