# Phase 4 - Test 1: PKI Infrastructure Test

**Test Date:** April 10, 2026  
**Tester:** KaliKlaw Security Assistant  
**Test:** PKI Infrastructure Integration  
**Status:** IN PROGRESS

---

## Test Objectives

Validate complete PKI infrastructure capability using all 7 available tools:
- OpenSSL
- GPG
- XCA
- Certbot
- JWT-Tool
- Smallstep
- CFSSL

---

## Tools Under Test

| Tool | Version | Location | Status |
|------|---------|----------|--------|
| **OpenSSL** | 3.5.5 | `/usr/bin/openssl` | ✅ Available |
| **GPG** | System | `/usr/bin/gpg` | ✅ Available |
| **XCA** | System | `/usr/bin/xca` | ✅ Available |
| **Certbot** | 4.0.0 | `/usr/bin/certbot` | ✅ Available |
| **JWT-Tool** | Latest | `/tmp/jwt_tool/jwt_tool.py` | ✅ Available |
| **Smallstep** | 0.30.2 | `/usr/local/bin/step` | ✅ Available |
| **CFSSL** | 1.6.5 | `/usr/local/bin/cfssl` | ✅ Available |

---

## Test Scenarios

### Scenario 1: OpenSSL Certificate Operations ✅

**Objective:** Generate and verify certificates with OpenSSL

**Commands:**
```bash
# Generate private key
openssl genrsa -out test-key.pem 2048

# Generate CSR
openssl req -new -key test-key.pem -out test.csr -subj "/CN=test.example.com"

# Generate self-signed cert
openssl x509 -req -days 365 -in test.csr -signkey test-key.pem -out test-cert.pem

# Verify certificate
openssl x509 -in test-cert.pem -text -noout | head -20
```

**Expected Result:** Certificate generated and verified successfully

**Status:** ⏳ PENDING

---

### Scenario 2: GPG Key Operations ✅

**Objective:** Generate GPG keys and test encryption/signing

**Commands:**
```bash
# Generate GPG key (batch mode)
gpg --batch --gen-key <<EOF
Key-Type: RSA
Key-Length: 2048
Name-Real: Test User
Name-Email: test@example.com
Expire-Date: 1y
%no-protection
%commit
EOF

# List keys
gpg --list-keys

# Test encryption
echo "Secret message" | gpg --encrypt --recipient test@example.com --armor

# Test signing
echo "Signed message" | gpg --sign --armor
```

**Expected Result:** GPG keys generated, encryption/signing works

**Status:** ⏳ PENDING

---

### Scenario 3: Smallstep Private CA ✅

**Objective:** Initialize and test Smallstep CA

**Commands:**
```bash
# Initialize CA (test mode)
step ca init --name "Test CA" --dns ca.test.local --address :443 --provisioner admin --password-file <(echo "password")

# Check CA status
step ca health

# Generate certificate
step ca certificate test.example.com test-cert.pem test-key.pem --password-file <(echo "password")

# Verify certificate
step certificate inspect test-cert.pem
```

**Expected Result:** CA initialized, certificate issued and verified

**Status:** ⏳ PENDING

---

### Scenario 4: CFSSL Certificate Generation ✅

**Objective:** Generate certificates with CFSSL

**Commands:**
```bash
# Create CA CSR
cat > ca-csr.json <<EOF
{
  "CN": "Test CA",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "ST": "California",
      "L": "San Francisco",
      "O": "Test Org",
      "OU": "Security"
    }
  ]
}
EOF

# Generate CA
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

# Create certificate CSR
cat > cert-csr.json <<EOF
{
  "CN": "test.example.com",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "ST": "California",
      "L": "San Francisco"
    }
  ]
}
EOF

# Generate certificate
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem cert-csr.json | cfssljson -bare test-cert

# Verify certificate
cfssl certinfo -cert test-cert.pem
```

**Expected Result:** CA and certificates generated with CFSSL

**Status:** ⏳ PENDING

---

### Scenario 5: Certbot Let's Encrypt ✅

**Objective:** Test Certbot with Let's Encrypt (staging)

**Commands:**
```bash
# Test with staging (dry-run)
certbot certonly --standalone --staging --agree-tos --email test@example.com -d test.example.com --dry-run

# Check certificates
certbot certificates
```

**Expected Result:** Certbot operational (staging environment)

**Status:** ⏳ PENDING

---

### Scenario 6: JWT-Tool Token Testing ✅

**Objective:** Create, analyze, and test JWT tokens

**Commands:**
```bash
# Create test JWT
python3 /tmp/jwt_tool/jwt_tool.py -T -a hs256 -p "test_secret" -c "user=test" -c "admin=true"

# Analyze JWT
python3 /tmp/jwt_tool/jwt_tool.py [JWT_TOKEN]

# Test algorithm confusion
python3 /tmp/jwt_tool/jwt_tool.py [JWT_TOKEN] -X a

# Forge token
python3 /tmp/jwt_tool/jwt_tool.py [JWT_TOKEN] -S sign -p "new_secret"
```

**Expected Result:** JWT tokens created, analyzed, and forged successfully

**Status:** ⏳ PENDING

---

### Scenario 7: XCA CA Management ✅

**Objective:** Test XCA for CA management (GUI)

**Commands:**
```bash
# Launch XCA
xca

# Create database
# Create CA
# Issue certificate
# Export certificate
```

**Expected Result:** XCA operational for CA management

**Status:** ⏳ PENDING (GUI application)

---

### Scenario 8: Tool Integration ✅

**Objective:** Validate tools work together

**Integration Tests:**
1. OpenSSL cert + JWT-Tool validation
2. Smallstep CA + CFSSL cert generation
3. GPG encryption + OpenSSL signing
4. Certbot + Smallstep for hybrid PKI

**Expected Result:** All tools integrate seamlessly

**Status:** ⏳ PENDING

---

## Test Execution Log

### Start Time: 2026-04-10 21:50 EDT

---

#### Scenario 1: OpenSSL

**Status:** ⏳ IN PROGRESS

**Commands Executed:**
```bash
openssl genrsa -out test-key.pem 2048
openssl req -new -key test-key.pem -out test.csr -subj "/CN=test.example.com"
openssl x509 -req -days 365 -in test.csr -signkey test-key.pem -out test-cert.pem
openssl x509 -in test-cert.pem -text -noout | head -20
```

**Results:**
- [ ] Key generated
- [ ] CSR created
- [ ] Certificate issued
- [ ] Certificate verified

**Evidence:**
- [ ] test-key.pem
- [ ] test.csr
- [ ] test-cert.pem

---

#### Scenario 2: GPG

**Status:** ⏳ PENDING

---

#### Scenario 3: Smallstep

**Status:** ⏳ PENDING

---

#### Scenario 4: CFSSL

**Status:** ⏳ PENDING

---

#### Scenario 5: Certbot

**Status:** ⏳ PENDING

---

#### Scenario 6: JWT-Tool

**Status:** ⏳ PENDING

---

#### Scenario 7: XCA

**Status:** ⏳ PENDING (GUI)

---

#### Scenario 8: Integration

**Status:** ⏳ PENDING

---

## Success Criteria

| Criterion | Target | Actual | Status |
|-----------|--------|--------|--------|
| **OpenSSL Operations** | 100% | TBD | ⏳ |
| **GPG Operations** | 100% | TBD | ⏳ |
| **Smallstep CA** | 100% | TBD | ⏳ |
| **CFSSL Operations** | 100% | TBD | ⏳ |
| **Certbot Operations** | 100% | TBD | ⏳ |
| **JWT-Tool Operations** | 100% | TBD | ⏳ |
| **XCA Operations** | 100% | TBD | ⏳ |
| **Tool Integration** | 100% | TBD | ⏳ |

---

## Test Results Summary

### Overall Status

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| **Scenarios Executed** | 8 | 0/8 | ⏳ |
| **Scenarios Passed** | 8 | 0/8 | ⏳ |
| **Tool Integration** | 100% | TBD | ⏳ |
| **Documentation** | 100% | TBD | ⏳ |

---

## Lessons Learned

### What Worked Well
- [ ] Tool availability
- [ ] Command execution
- [ ] Certificate generation
- [ ] Integration between tools

### Challenges
- [ ] Any installation issues
- [ ] Tool compatibility
- [ ] Integration challenges
- [ ] Documentation gaps

### Recommendations
- [ ] Tool improvements
- [ ] Process enhancements
- [ ] Documentation updates
- [ ] Training needs

---

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| **Tester** | KaliKlaw | 2026-04-10 | ⏳ In Progress |
| **Reviewer** | Pending | - | - |
| **Approved** | Pending | - | - |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Status:** ⏳ IN PROGRESS - Scenario 1 (OpenSSL)
