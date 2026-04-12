# Security Policy

## Reporting a Vulnerability

We take the security of this project seriously. If you discover security issues, please follow this process:

### 🚫 DO NOT
- Create a public GitHub issue
- Discuss the vulnerability publicly before it's resolved
- Exploit the vulnerability beyond what's necessary to identify it

### ✅ DO
1. **Email:** security@mexbalia.mx
2. **Include:**
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)
3. **Wait:** Allow 48 hours for initial response

## What We Monitor

This repository is scanned for:

| Category | Examples |
|----------|----------|
| **API Keys** | Google, AWS, Azure, GitHub tokens |
| **Tokens** | OAuth, PAT, bot tokens, session tokens |
| **Credentials** | Passwords, connection strings |
| **Private Keys** | SSH keys, TLS certificates, PGP keys |
| **Infrastructure** | Internal IPs, hostnames, network topology |

## Security Best Practices

### For Contributors
- Never commit credentials, even in examples
- Use environment variables for secrets
- Use placeholders like `<your-api-key>` in documentation
- Sanitize internal infrastructure details

### For Users
- Review code before deploying
- Rotate any credentials that may have been exposed
- Report accidental commits immediately

## Response Timeline

| Severity | Response Time | Resolution Target |
|----------|---------------|-------------------|
| 🔴 Critical | 24 hours | 7 days |
| 🟡 High | 48 hours | 14 days |
| 🟢 Medium | 7 days | 30 days |
| 🔵 Low | 14 days | Next release |

## Past Security Advisories

| Date | Issue | Status |
|------|-------|--------|
| 2026-04-12 | Google API Key exposure | ✅ Resolved - Purged from history |

---

**Thank you for helping keep this project secure!** 🛡️
