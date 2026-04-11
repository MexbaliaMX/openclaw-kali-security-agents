# Agentic Identity Trust - Kali Linux Tool Mapping

**Agent:** 🔐 Agentic Identity Trust  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 18  
**Status:** Complete

---

## Overview

**Mission:** Identity verification, trust systems, authentication flow testing, and PKI management.

**Primary Use Cases:**
- Identity verification systems
- Authentication flow testing
- PKI and certificate management
- MFA/2FA testing
- Session management validation
- Trust boundary analysis

---

## 1. Authentication Testing

### Auth Testing Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **oauth-tester** | oauth-tester (manual) | OAuth flow testing | Web interface |
| **samlraider** | samlraider (burp) | SAML testing | Burp extension |
| **jwt-tool** | jwt-tool (pip) | JWT testing | `jwt-tool TOKEN` |
| **kerbrute** | kerbrute (go) | Kerberos brute-force | `kerbrute bruteusernames` |
| **crackmapexec** | crackmapexec | Network exploitation | `crackmapexec smb target` |

### JWT Testing Examples
```bash
# Analyze token
jwt-tool eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Test algorithm confusion
jwt-tool TOKEN --test-all

# Crack weak secret
jwt-tool TOKEN --dict wordlist.txt

# Forge token
jwt-tool --forge --payload '{"admin":true}' --secret secret
```

### OAuth Testing Workflow
```
1. Identify OAuth endpoints
2. Test authorization code flow
3. Test implicit flow
4. Test client credentials
5. Test refresh tokens
6. Check for PKCE implementation
7. Validate redirect URIs
8. Test scope enforcement
```

---

## 2. PKI & Certificate Management

### PKI Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **openssl** | openssl | Certificate toolkit | `openssl x509 -in cert.pem -text` |
| **xca** | xca | Certificate authority | GUI application |
| **cfssl** | cfssl (manual) | PKI toolkit | `cfssl gencert` |
| **smallstep** | step-ca (manual) | Private CA | `step ca init` |
| **certbot** | certbot | Let's Encrypt | `certbot certonly` |

### OpenSSL Common Commands
```bash
# Generate private key
openssl genrsa -out private.key 4096

# Generate CSR
openssl req -new -key private.key -out request.csr \
  -subj "/C=US/ST=State/L=City/O=Org/CN=domain.com"

# Generate self-signed certificate
openssl req -x509 -newkey rsa:4096 \
  -keyout key.pem -out cert.pem -days 365

# Verify certificate
openssl x509 -in cert.pem -text -noout

# Check certificate chain
openssl verify -CAfile ca.pem cert.pem

# Convert formats
openssl pkcs12 -in cert.pfx -out cert.pem -nodes

# Extract public key
openssl x509 -in cert.pem -pubkey -noout > public.key
```

### XCA Workflow
```
1. Create new database
2. Generate CA certificate
3. Create server certificate
4. Create client certificates
5. Export in required format
6. Distribute to clients
```

---

## 3. MFA/2FA Testing

### MFA Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **oath-toolkit** | oath-toolkit | OATH toolkit | `oathtool --totp SECRET` |
| **google-authenticator** | libpam-google-authenticator | Google Authenticator | `google-authenticator` |
| **ykpers** | ykpers | YubiKey personalization | `ykpersonalize` |
| **yubikey-manager** | yubikey-manager | YubiKey management | `ykman` |

### TOTP Testing
```bash
# Generate TOTP code
oathtool --totp --base32 JBSWY3DPEHPK3PXP

# Verify TOTP
oathtool --totp --base32 -v JBSWY3DPEHPK3PXP

# Test time drift
for i in {1..5}; do
  oathtool --totp --base32 -w $i JBSWY3DPEHPK3PXP
done
```

---

## 4. Session Management

### Session Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **burpsuite** | burpsuite | Web proxy | GUI application |
| **zap** | owasp-zap | Web scanner | GUI application |
| **cookie-cadger** | cookie-cadger | Cookie analysis | GUI application |

### Session Security Checklist
- [ ] Session ID entropy
- [ ] Session timeout
- [ ] Session invalidation on logout
- [ ] Secure cookie flags
- [ ] SameSite attribute
- [ ] Session fixation protection
- [ ] Concurrent session limits

---

## 5. Identity Protocols

### Protocol Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **ldapsearch** | ldap-utils | LDAP queries | `ldapsearch -x -H ldap://target` |
| **ldiff** | ldap-utils | LDAP comparison | `ldiff file1.ldif file2.ldif` |
| **radtest** | freeradius | RADIUS testing | `radtest user pass localhost 0 testing123` |

### LDAP Testing
```bash
# Anonymous bind
ldapsearch -x -H ldap://target.com -b "dc=target,dc=com"

# Authenticated bind
ldapsearch -x -H ldap://target.com \
  -D "cn=admin,dc=target,dc=com" -W \
  -b "dc=target,dc=com" "(objectClass=*)"

# Search for users
ldapsearch -x -H ldap://target.com \
  -b "ou=users,dc=target,dc=com" "(uid=*)"
```

---

## 6. Trust Boundary Analysis

### Analysis Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **wireshark** | wireshark | Protocol analysis | `wireshark -i eth0` |
| **mitmproxy** | mitmproxy | MITM proxy | `mitmproxy` |
| **bettercap** | bettercap | Network attacks | `bettercap -iface eth0` |

---

## Top 10 Identity Trust Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **JWT-Tool** | Testing | JWT security testing |
| 2 | **OpenSSL** | PKI | Certificate management |
| 3 | **Burp Suite** | Testing | Web authentication testing |
| 4 | **XCA** | PKI | Certificate authority |
| 5 | **OAuth-Tester** | Testing | OAuth flow testing |
| 6 | **SAML Raider** | Testing | SAML security |
| 7 | **OATH-Toolkit** | MFA | TOTP/HOTP testing |
| 8 | **YubiKey Manager** | MFA | Hardware token management |
| 9 | **LDAP Search** | Identity | Directory queries |
| 10 | **Kerbrute** | Testing | Kerberos testing |

---

## Quick Reference Commands

### Certificate Operations
```bash
# Generate CA
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.pem

# Generate server cert
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -out server.pem -days 365
```

### JWT Testing
```bash
# Decode without verification
jwt-tool TOKEN --decode

# Test all attacks
jwt-tool TOKEN --test-all

# Forge admin token
jwt-tool --payload '{"sub":"admin","iat":1234567890}' --secret secret
```

### MFA Testing
```bash
# Generate TOTP
oathtool --totp --base32 SECRET

# Test multiple time windows
for i in -2 -1 0 1 2; do
  oathtool --totp --base32 -w $i SECRET
done
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **PKI** | OpenSSL |
| **Testing** | Burp Suite, JWT-Tool |
| **MFA** | OATH-Toolkit |
| **Network** | Wireshark, Bettercap |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **XCA** | apt | Certificate authority |
| **CFSSL** | Download binary | PKI toolkit |
| **Smallstep** | apt | Private CA |
| **OAuth-Tester** | GitHub | OAuth testing |
| **SAML Raider** | Burp extension | SAML testing |
| **YubiKey Manager** | apt | YubiKey management |
| **Certbot** | apt | Let's Encrypt |

---

## Identity Security Checklist

### Authentication
- [ ] Strong password policies
- [ ] MFA enforcement
- [ ] Account lockout
- [ ] Password history
- [ ] Secure password reset

### Authorization
- [ ] Role-based access control
- [ ] Least privilege
- [ ] Separation of duties
- [ ] Regular access reviews

### Session Management
- [ ] Secure session IDs
- [ ] Timeout enforcement
- [ ] Secure cookie flags
- [ ] Session invalidation

### PKI
- [ ] Certificate validation
- [ ] Chain of trust
- [ ] Revocation checking
- [ ] Key rotation

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly  
**Owner:** Security Team
