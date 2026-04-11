# Specialized Security Agents - Planning Document

**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Complement:** Red/Blue/Purple Team Agents, Unified AI Security Framework

---

## Overview

This document plans six specialized security agent modes for focused offensive security operations:

| Agent | Domain | Primary Focus |
|-------|--------|---------------|
| 🌐 **Web Pentesting** | Web Applications | OWASP Top 10, API security, business logic flaws |
| 💰 **Bug Bounty** | Coordinated Disclosure | Recon methodology, bounty optimization, responsible disclosure |
| 🔁 **Replay Attack** | Authentication/Protocol | Session manipulation, cryptographic attacks, auth bypass |
| 🔍 **Reverse Engineering** | Binary/Malware Analysis | Decompilation, vulnerability discovery, malware analysis |
| 📡 **Sub-GHz SDR** | RF/IoT Security | Software Defined Radio, wireless protocols, IoT pentesting |
| 📶 **WiFi Security** | Wireless Networks | WPA/WPA2/WPA3, enterprise networks, wireless auditing |

---

## 🌐 Web Pentesting Agent

### Mission Statement

> "Break the web, find the bugs, secure the application."

Specialized in web application security testing, API vulnerability assessment, and business logic exploitation across modern web architectures.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Reconnaissance** | Subdomain enumeration, directory brute-forcing, tech stack fingerprinting | Application map, attack surface |
| **OWASP Top 10 Testing** | SQLi, XSS, CSRF, SSRF, XXE, RCE, IDOR, authentication flaws | Vulnerability list with PoC |
| **API Security** | REST/GraphQL testing, authentication bypass, rate limiting, schema introspection | API vulnerability report |
| **Business Logic** | Workflow abuse, privilege escalation, race conditions, payment manipulation | Logic flaw documentation |
| **Client-Side** | DOM XSS, prototype pollution, CSP bypass, postMessage vulnerabilities | Frontend security report |
| **Server-Side** | SSTI, deserialization, file inclusion, command injection | Backend vulnerability report |

### OWASP Top 10 2021 Coverage

| Vulnerability | Testing Approach | Tools |
|---------------|------------------|-------|
| **A01: Broken Access Control** | IDOR testing, privilege escalation, forced browsing | Burp Suite, AuthMatrix |
| **A02: Cryptographic Failures** | Weak cipher detection, sensitive data exposure | SSL Labs, custom scripts |
| **A03: Injection** | SQLi, NoSQLi, OS command, LDAP injection | SQLmap, Burp Intruder |
| **A04: Insecure Design** | Threat modeling, business logic abuse | Manual testing, flow analysis |
| **A05: Security Misconfiguration** | Default creds, verbose errors, unnecessary services | Nmap, Nikto, custom scans |
| **A06: Vulnerable Components** | Dependency scanning, CVE matching | Snyk, npm audit, Retire.js |
| **A07: Auth Failures** | Credential stuffing, session fixation, MFA bypass | Hydra, Burp Suite |
| **A08: Data Integrity** | Deserialization attacks, JWT manipulation | ysoserial, jwt.io |
| **A09: Logging Failures** | Audit trail testing, log injection | Manual testing |
| **A10: SSRF** | Server-side request forgery, cloud metadata | Burp Collaborator, custom payloads |

### Additional Web Attack Vectors

| Vector | Description | Tools |
|--------|-------------|-------|
| **XSS (Cross-Site Scripting)** | Reflected, Stored, DOM-based | XSStrike, Dalfox, Burp |
| **CSRF (Cross-Site Request Forgery)** | State-changing action forcing | Burp Suite, custom PoC |
| **XXE (XML External Entity)** | XML parser exploitation | XXEinjector, Burp |
| **SSTI (Server-Side Template Injection)** | Template engine exploitation | TPLMap, manual testing |
| **HTTP Smuggling** | Request desync attacks | Smuggler, Burp Suite |
| **Web Cache Poisoning** | Cache key manipulation | Param Miner, Burp |
| **OAuth/OpenID Misconfiguration** | Auth flow abuse | OAuth tester, manual |
| **GraphQL Vulnerabilities** | Introspection, batching, injection | GraphQLmap, InQL |

### Tools & Skills Integration

| Tool Category | Specific Tools | Integration |
|---------------|----------------|-------------|
| **Proxy/Scanner** | Burp Suite Pro, OWASP ZAP, Caido | Primary testing platform |
| **SQL Injection** | SQLmap, NoSQLmap, custom payloads | Automated exploitation |
| **XSS** | XSStrike, Dalfox, XSpear | XSS detection/exploitation |
| **Directory Brute** | Gobuster, Dirb, Ffuf, Wfuzz | Content discovery |
| **Subdomain Enum** | Subfinder, Amass, Assetfinder, Sublist3r | Reconnaissance |
| **API Testing** | Postman, Insomnia, Kiterunner, Arjun | API security |
| **Fuzzing** | Burp Intruder, Ffuf, Wfuzz, custom wordlists | Input validation testing |
| **Cloud** | Pacu (AWS), ScoutSuite, cloud enumeration | Cloud-specific testing |

### Engagement Workflow

```
Phase 1 - Reconnaissance (20% time):
  □ Subdomain enumeration
  □ Technology fingerprinting (Wappalyzer, BuiltWith)
  □ Directory/file brute-forcing
  □ Parameter discovery
  □ Archive/wayback analysis
  □ JavaScript file analysis (secrets, endpoints)

Phase 2 - Automated Scanning (20% time):
  □ Burp Suite crawl/scan
  □ OWASP ZAP baseline scan
  □ Nuclei template scanning
  □ Dependency vulnerability scan

Phase 3 - Manual Testing (50% time):
  □ Authentication testing
  □ Authorization/IDOR testing
  □ Input validation (all parameters)
  □ Business logic workflows
  □ Session management
  □ File upload testing
  □ API endpoint testing

Phase 4 - Post-Exploitation (10% time):
  □ Data access verification
  □ Privilege escalation paths
  □ Lateral movement possibilities

Phase 5 - Reporting (100% of findings time):
  □ Executive summary
  □ Technical findings with PoC
  □ Remediation recommendations
  □ Risk ratings (CVSS)
```

### Deliverables

| Document | Content | Format |
|----------|---------|--------|
| **Executive Summary** | Risk overview, business impact, top findings | PDF, 2-3 pages |
| **Technical Report** | All findings, CVSS scores, reproduction steps | PDF, detailed |
| **Proof of Concept** | Screenshots, videos, curl commands, exploit code | Attached evidence |
| **Remediation Guide** | Fix recommendations, code examples, priority | PDF + code snippets |
| **Retest Report** | Validation of fixes, residual risk | PDF (post-remediation) |

### Activation

```
"Activate Web Pentesting mode"
"Activate Web Pentesting mode - test [target] for OWASP Top 10"
"Activate Web Pentesting mode - API security assessment for [endpoint]"
```

---

## 💰 Bug Bounty Agent

### Mission Statement

> "Find bugs responsibly, maximize impact, get paid fairly."

Specialized in coordinated vulnerability disclosure, bounty hunting methodology, and maximizing legitimate earnings through ethical hacking platforms.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Target Selection** | Program research, scope analysis, payout history | Target priority list |
| **Recon Methodology** | Systematic enumeration, asset discovery, change detection | Comprehensive asset inventory |
| **Vulnerability Research** | CVE analysis, PoC development, impact demonstration | Validated vulnerability |
| **Report Writing** | Clear reproduction, impact articulation, remediation suggestions | High-quality disclosure |
| **Platform Optimization** | HackerOne, Bugcrowd, Intigriti, direct programs | Maximize bounty potential |
| **Responsible Disclosure** | Coordinated disclosure, embargo handling, CVE requests | Professional reputation |

### Bounty Platform Coverage

| Platform | Focus | Payout Range | Notes |
|----------|-------|--------------|-------|
| **HackerOne** | Enterprise programs | $100 - $50,000+ | Largest platform, varied programs |
| **Bugcrowd** | Diverse programs | $100 - $30,000+ | Good for beginners, crowdcontrol |
| **Intigriti** | European focus | €100 - €25,000+ | Monthly challenges, community |
| **YesWeHack** | EU-based | €100 - €20,000+ | GDPR-focused programs |
| **Open Source** | Internet Bug Bounty | $500 - $50,000 | Critical infrastructure |
| **Direct Programs** | Company-run | Varies | Google VRP, Microsoft, etc. |

### Recon Methodology (Systematic Approach)

```
Level 1 - Passive Recon (No interaction with target):
  □ Subdomain enumeration (passive sources)
    - Subfinder, Amass (passive), Certificate Transparency
    - Sources: crt.sh, SecurityTrails, VirusTotal
  □ DNS enumeration
    - DNS records, MX, TXT, SPF, DMARC
  □ Technology identification
    - Wappalyzer, BuiltWith, WhatWeb
  □ Archive analysis
    - Wayback Machine, archive.is
  □ Code repository analysis
    - GitHub, GitLab, Bitbucket (leaked secrets)
  □ Job postings
    - Tech stack clues, infrastructure hints

Level 2 - Active Recon (Safe interaction):
  □ Subdomain brute-forcing
    - Gobuster, Puredns, Massdns
  □ Port scanning
    - Nmap, Masscan (rate-limited)
  □ Web crawling
    - Burp Suite, Gospider, Katana
  □ Directory brute-forcing
    - Ffuf, Dirsearch, Gobuster
  □ Parameter discovery
    - Arjun, ParamSpider
  □ Screenshot capture
    - Aquatone, Eyewitness

Level 3 - Deep Recon (Targeted):
  □ JavaScript analysis
    - Extract endpoints, secrets, API keys
    - Tools: JSFScan, LinkFinder, SecretFinder
  □ API enumeration
    - OpenAPI specs, GraphQL introspection
  □ Cloud bucket discovery
    - S3, Azure Blob, GCS enumeration
  □ WAF detection
    - Wafw00f, manual testing
  □ Change detection
    - Visual monitoring, new subdomain alerts
```

### High-Value Vulnerability Types

| Vulnerability | Average Bounty | Difficulty | Competition |
|---------------|----------------|------------|-------------|
| **RCE (Remote Code Execution)** | $5,000 - $50,000+ | High | Low |
| **SQL Injection** | $2,000 - $15,000 | Medium | Medium |
| **IDOR (Critical data)** | $1,000 - $10,000 | Medium | High |
| **SSRF (Cloud metadata)** | $2,000 - $20,000 | Medium | Medium |
| **XSS (Authenticated)** | $500 - $5,000 | Low | High |
| **Account Takeover** | $2,000 - $25,000 | Medium | Medium |
| **Business Logic** | $1,000 - $15,000 | High | Low |
| **Authentication Bypass** | $2,000 - $20,000 | High | Low |
| **XXE (File read)** | $1,500 - $10,000 | Medium | Medium |
| **Deserialization** | $3,000 - $25,000 | High | Low |

### Report Template (High-Quality Disclosure)

```markdown
# Vulnerability Report

## Summary
[Brief one-paragraph description]

## Vulnerability Details
- **Type:** [Vulnerability type]
- **Severity:** [Critical/High/Medium/Low]
- **CVSS Score:** [X.X]
- **Location:** [URL/Endpoint]
- **Affected Parameters:** [Parameters]

## Reproduction Steps
1. [Step 1]
2. [Step 2]
3. [Step 3]
4. [Expected vs. Actual behavior]

## Proof of Concept
[Code, curl commands, screenshots]

## Impact
[What can an attacker achieve? Business impact]

## Remediation
[Recommended fix with code examples]

## References
[Similar CVEs, OWASP links, vendor documentation]
```

### Tools & Skills Integration

| Tool Category | Specific Tools | Purpose |
|---------------|----------------|---------|
| **Recon Automation** | Recon-ng, theHarvester, OSINT frameworks | Asset discovery |
| **Subdomain Enum** | Subfinder, Amass, Puredns, Assetfinder | Subdomain discovery |
| **Content Discovery** | Ffuf, Gobuster, Dirsearch, Kiterunner | Path/parameter finding |
| **Screenshot** | Aquatone, Eyewitness, httpx | Visual recon |
| **JS Analysis** | LinkFinder, JSFScan, SecretFinder | Secret/endpoint extraction |
| **Change Detection** | Visualping, custom monitors | New asset alerts |
| **Report Writing** | Templates, Markdown, screenshots | Quality disclosures |

### Bounty Hunting Workflow

```
Week 1-2: Target Selection & Recon
  □ Research programs (scope, payout history, response time)
  □ Passive recon (subdomains, tech stack, archives)
  □ Active recon (brute-forcing, scanning)
  □ Asset inventory creation

Week 3-4: Vulnerability Research
  □ Test high-value targets first
  □ Focus on low-competition vulnerability types
  □ Develop PoCs for promising findings
  □ Document everything

Week 5+: Reporting & Follow-up
  □ Write clear, detailed reports
  □ Respond quickly to triage questions
  □ Provide additional info as requested
  □ Learn from duplicates/rejections
```

### Best Practices

| Do ✅ | Don't ❌ |
|-------|---------|
| Read scope carefully | Test out-of-scope assets |
| Test during allowed hours | DDoS or stress test |
| Document thoroughly | Submit low-effort reports |
| Communicate professionally | Argue with triage team |
| Learn from duplicates | Submit duplicate bugs |
| Focus on impact | Chase low-bounty vulns only |
| Build reputation | Burn bridges with programs |

### Activation

```
"Activate Bug Bounty mode"
"Activate Bug Bounty mode - recon methodology for [target]"
"Activate Bug Bounty mode - write report for [vulnerability]"
"Activate Bug Bounty mode - recommend high-value targets"
```

---

## 🔁 Replay Attack Agent

### Mission Statement

> "Capture, analyze, replay, bypass."

Specialized in authentication protocol analysis, session manipulation, cryptographic attack vectors, and replay-based exploitation.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Traffic Capture** | Packet capture, proxy interception, log analysis | Captured authentication flows |
| **Protocol Analysis** | OAuth, SAML, JWT, Kerberos, NTLM | Protocol vulnerability assessment |
| **Session Attacks** | Session fixation, hijacking, replay | Session bypass PoC |
| **Token Manipulation** | JWT cracking, tampering, algorithm confusion | Token exploitation |
| **Credential Replay** | Password hash replay, pass-the-hash/ticket | Auth bypass |
| **API Replay** | Request replay, timestamp bypass, nonce reuse | API authentication bypass |

### Attack Vectors

| Vector | Description | Tools |
|--------|-------------|-------|
| **Session Replay** | Capture and replay valid session tokens | Burp Suite, custom scripts |
| **JWT Attacks** | Algorithm confusion, key confusion, none algorithm | jwt.io, jwt_tool, Burp |
| **OAuth Flow Abuse** | Authorization code replay, token theft | OAuth tester, Burp |
| **SAML Exploitation** | Signature bypass, assertion replay | SAML Raider, Burp |
| **Kerberos Attacks** | Pass-the-hash, pass-the-ticket, golden ticket | Impacket, Mimikatz |
| **NTLM Relay** | NTLM relay attacks, credential forwarding | Responder, Impacket |
| **Timestamp Bypass** | Replay requests with modified timestamps | Burp Suite, custom |
| **Nonce Reuse** | Replay requests with reused nonces | Custom scripts |

### JWT Attack Toolkit

| Attack | Description | Tool/Method |
|--------|-------------|-------------|
| **Algorithm Confusion** | Change RS256 → HS256, use public key as secret | jwt_tool |
| **None Algorithm** | Set alg=none, remove signature | jwt.io, manual |
| **Key Confusion** | Inject jwk/jku headers | jwt_tool |
| **Brute Force** | Crack weak secrets | Hashcat, jwt_tool |
| **Claim Manipulation** | Modify payload claims | jwt.io, Burp |
| **Token Replay** | Reuse expired/valid tokens | Burp Repeater |

### Tools & Skills Integration

| Tool Category | Specific Tools | Purpose |
|---------------|----------------|---------|
| **Proxy/Interceptor** | Burp Suite, OWASP ZAP, mitmproxy | Traffic capture/modification |
| **JWT Testing** | jwt_tool, jwt.io, JOSE | Token analysis/exploitation |
| **Windows Auth** | Impacket, Mimikatz, Rubeus | Kerberos/NTLM attacks |
| **SAML** | SAML Raider, Burp extensions | SAML testing |
| **OAuth** | OAuth tester, custom scripts | OAuth flow testing |
| **Packet Capture** | Wireshark, tcpdump | Network traffic analysis |
| **Hash Cracking** | Hashcat, John the Ripper | Credential cracking |

### Common Replay Attack Scenarios

| Scenario | Attack Vector | Mitigation |
|----------|---------------|------------|
| **API Authentication** | Replay captured requests | Timestamps, nonces, request signing |
| **Session Management** | Session token replay | Token rotation, expiration, binding |
| **Payment Systems** | Transaction replay | Idempotency keys, transaction IDs |
| **Two-Factor Auth** | TOTP code replay | Time windows, single-use codes |
| **Webhook Verification** | Webhook replay | Signature validation, timestamps |
| **Mobile App Auth** | API call replay | Certificate pinning, request signing |

### Testing Methodology

```
Phase 1 - Capture:
  □ Intercept authentication flow
  □ Capture tokens, cookies, headers
  □ Document request/response pairs
  □ Identify replay targets

Phase 2 - Analysis:
  □ Token structure analysis (JWT, session IDs)
  □ Timestamp/nonce presence
  □ Signature validation requirements
  □ Expiration mechanisms

Phase 3 - Replay Testing:
  □ Simple replay (exact request)
  □ Modified timestamp replay
  □ Token manipulation
  □ Cross-session replay
  □ Cross-user replay

Phase 4 - Exploitation:
  □ Develop reliable PoC
  □ Test impact (data access, actions)
  □ Document bypass chain

Phase 5 - Reporting:
  □ Clear reproduction steps
  □ Impact assessment
  □ Mitigation recommendations
```

### Activation

```
"Activate Replay Attack mode"
"Activate Replay Attack mode - analyze [protocol] for replay vulnerabilities"
"Activate Replay Attack mode - JWT security assessment"
"Activate Replay Attack mode - session management testing"
```

---

## 🔍 Reverse Engineering Specialist Agent

### Mission Statement

> "Dissect the binary, understand the logic, find the flaws."

Specialized in binary analysis, decompilation, malware reverse engineering, and vulnerability discovery in compiled software.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Static Analysis** | Disassembly, decompilation, string analysis | Code flow understanding |
| **Dynamic Analysis** | Debugging, instrumentation, tracing | Runtime behavior |
| **Malware Analysis** | Behavioral analysis, C2 extraction, IOC identification | Malware report |
| **Vulnerability Discovery** | Buffer overflow, use-after-free, ROP chains | Vulnerability PoC |
| **Protocol RE** | Custom protocol analysis, encryption analysis | Protocol documentation |
| **Firmware RE** | Embedded system analysis, IoT firmware | Firmware vulnerability report |

### Analysis Types

| Type | Description | Tools |
|------|-------------|-------|
| **Static RE** | Analyze without executing | IDA Pro, Ghidra, Binary Ninja |
| **Dynamic RE** | Analyze during execution | x64dbg, GDB, Frida, WinDbg |
| **Hybrid RE** | Combine static and dynamic | All of the above |
| **Automated RE** | Scripted analysis | Ghidra scripts, angr, Triton |

### Tool Stack

| Category | Tools | Purpose |
|----------|-------|---------|
| **Disassemblers** | IDA Pro, Ghidra, Binary Ninja, radare2 | Static analysis |
| **Decompilers** | Ghidra, IDA Decompiler, RetDec | Pseudo-code generation |
| **Debuggers** | x64dbg, GDB, WinDbg, LLDB | Dynamic analysis |
| **Instrumentation** | Frida, DynamoRIO, Intel PIN | Runtime modification |
| **Malware Analysis** | ANY.RUN, Joe Sandbox, Cuckoo | Behavioral analysis |
| **Binary Exploitation** | pwntools, ROPgadget, angr | Exploit development |
| **Firmware** | binwalk, Firmwalker, FACT | Firmware analysis |

### Common RE Targets

| Target | Analysis Focus | Common Findings |
|--------|----------------|-----------------|
| **Windows Executables** | PE structure, imports, anti-analysis | Malware, license bypass, vulns |
| **Linux Binaries** | ELF structure, syscalls, libraries | Backdoors, rootkits, vulns |
| **Mobile Apps (Android)** | APK analysis, native libraries | Hardcoded secrets, logic flaws |
| **Mobile Apps (iOS)** | IPA analysis, Mach-O binaries | Jailbreak detection bypass |
| **Firmware** | Embedded OS, bootloaders, configs | Backdoors, hardcoded creds |
| **IoT Devices** | Custom protocols, update mechanisms | Auth bypass, command injection |
| **Drivers** | Kernel code, privilege boundaries | LPE vulnerabilities |
| **Libraries** | Crypto implementations, parsers | Vulnerable components |

### Malware Analysis Workflow

```
Phase 1 - Triage (Basic Analysis):
  □ File type identification (file, TrID)
  □ Hash calculation (MD5, SHA1, SHA256)
  □ Strings extraction (strings, FLOSS)
  □ PE/ELF structure analysis (PEStudio)
  □ VirusTotal lookup
  □ Basic YARA rule matching

Phase 2 - Static Analysis:
  □ Disassembly (IDA/Ghidra)
  □ Import/Export analysis
  □ String analysis (URLs, IPs, domains)
  □ Anti-analysis detection
  □ Configuration extraction

Phase 3 - Dynamic Analysis:
  □ Sandbox execution (ANY.RUN, Joe Sandbox)
  □ Network traffic monitoring
  □ File system changes
  □ Registry changes (Windows)
  □ Process injection detection
  □ Persistence mechanisms

Phase 4 - Code Analysis:
  □ Control flow analysis
  □ Crypto function identification
  □ C2 communication analysis
  □ Payload extraction
  □IOC generation

Phase 5 - Reporting:
  □ Malware family identification
  □ Capabilities summary
  □ IOC list (IOCs for detection)
  □ Mitigation recommendations
```

### Vulnerability Discovery Process

```
Step 1 - Target Selection:
  □ Choose binary (closed-source software, drivers, firmware)
  □ Identify attack surface (parsers, network handlers, user input)

Step 2 - Initial Analysis:
  □ Static analysis to understand structure
  □ Identify input handling functions
  □ Map control flow

Step 3 - Vulnerability Hunting:
  □ Look for dangerous functions (strcpy, sprintf, gets)
  □ Analyze memory management
  □ Check for integer overflows
  □ Identify race conditions

Step 4 - Exploit Development:
  □ Create PoC trigger
  □ Develop exploit (buffer overflow, ROP, etc.)
  □ Test reliability

Step 5 - Disclosure:
  □ Vendor notification
  □ CVE request
  □ Responsible disclosure timeline
```

### Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Android Pentesting** | Native library analysis, anti-reversing bypass |
| **Web Pentesting** | Custom protocol analysis, encryption analysis |
| **Red Team** | Custom tool development, AV evasion |
| **Bug Bounty** | Mobile app RE, hardcoded secret discovery |
| **WiFi Security** | Firmware analysis, protocol RE |

### Activation

```
"Activate Reverse Engineering mode"
"Activate Reverse Engineering mode - analyze [binary/malware]"
"Activate Reverse Engineering mode - firmware analysis for [device]"
"Activate Reverse Engineering mode - vulnerability discovery in [software]"
```

---

## 📡 Sub-GHz SDR Specialist Agent

### Mission Statement

> "Listen to the spectrum, decode the signals, own the airwaves."

Specialized in Software Defined Radio (SDR) operations, sub-GHz wireless protocol analysis, IoT security, and RF-based attacks.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Signal Intelligence** | Spectrum analysis, signal detection, frequency hunting | Signal inventory |
| **Protocol Analysis** | Reverse engineering wireless protocols | Protocol documentation |
| **Signal Replay** | Capture and replay RF signals | Access bypass |
| **IoT Security** | Smart home, automotive, industrial IoT | IoT vulnerability report |
| **Encryption Analysis** | Rolling code, fixed code, encryption schemes | Crypto assessment |
| **Antenna Design** | Custom antenna building, signal optimization | Improved range/capture |

### Frequency Coverage

| Band | Frequency | Common Uses |
|------|-----------|-------------|
| **LF** | 30-300 kHz | RFID, access control |
| **HF** | 3-30 MHz | Amateur radio, shortwave |
| **VHF** | 30-300 MHz | FM radio, aviation, marine |
| **UHF** | 300 MHz - 3 GHz | TV, cellular, WiFi, Bluetooth |
| **Sub-GHz** | 300-928 MHz | IoT, garage doors, car remotes |
| **ISM** | 433/868/915 MHz | Wireless sensors, smart home |

### Common Sub-GHz Protocols

| Protocol | Frequency | Use Case | Security |
|----------|-----------|----------|----------|
| **ASK/OOK** | 433/868/915 MHz | Garage doors, gates | Fixed code (weak) |
| **FSK** | 433/868/915 MHz | Sensors, remotes | Varies |
| **Rolling Code** | 433/868/915 MHz | Car remotes, gates | Better but replayable |
| **Z-Wave** | 868/908/921 MHz | Smart home | AES-128 |
| **Zigbee** | 868/900/2400 MHz | Smart home, industrial | AES-128 |
| **LoRa/LoRaWAN** | 868/915 MHz | Long-range IoT | AES-128 |
| **EnOcean** | 868/902 MHz | Building automation | Weak/none |
| **KEELOQ** | 433 MHz | Automotive | Broken crypto |

### Hardware Stack

| Device | Frequency Range | Use Case | Price |
|--------|-----------------|----------|-------|
| **RTL-SDR** | 24-1766 MHz | Receive only, beginner | $25 |
| **HackRF One** | 1-6000 MHz | TX/RX, half-duplex | $300 |
| **YARD Stick One** | 300-928 MHz | Sub-GHz pentesting | $100 |
| **Flipper Zero** | 300-928 MHz | Multi-tool, portable | $200 |
| **Ubertooth** | 2.4 GHz | Bluetooth analysis | $150 |
| **PlutoSDR** | 325-3800 MHz | Full-duplex, ADALM | $400 |
| **LimeSDR** | 100-3800 MHz | Full-duplex, flexible | $280 |

### Software Stack

| Software | Purpose | Platform |
|----------|---------|----------|
| **SDR#** | General SDR receiver | Windows |
| **GQRX** | SDR receiver | Linux/macOS |
| **GNU Radio** | SDR development framework | Cross-platform |
| **URH** | Universal Radio Hacker | Cross-platform |
| **Inspectrum** | Signal analysis | Cross-platform |
| **rtl_433** | Sensor protocol decoder | Cross-platform |
| **rfcat** | RF testing framework | Python |
| **gr-zigbee** | Zigbee analysis | GNU Radio |

### Attack Scenarios

| Target | Attack Vector | Tool |
|--------|---------------|------|
| **Garage Doors** | Fixed code capture/replay | RTL-SDR, URH |
| **Car Remotes** | Rolling code jam/replay | HackRF, rfcat |
| **Smart Home** | Z-Wave/Zigbee analysis | Ubertooth, KillerBee |
| **IoT Sensors** | Protocol analysis, spoofing | rtl_433, GNU Radio |
| **Access Control** | RFID/NFC cloning | Proxmark, Chameleon |
| **Industrial IoT** | LoRaWAN analysis | LoRa gateway, Wireshark |

### Testing Methodology

```
Phase 1 - Reconnaissance:
  □ Spectrum survey (identify active frequencies)
  □ Signal documentation (type, modulation, bandwidth)
  □ Protocol identification
  □ Target prioritization

Phase 2 - Signal Capture:
  □ Record signals (multiple captures)
  □ Document context (button pressed, action triggered)
  □ Extract raw data
  □ Identify patterns

Phase 3 - Analysis:
  □ Modulation identification (ASK, FSK, PSK)
  □ Data rate calculation
  □ Protocol structure analysis
  □ Encryption detection

Phase 4 - Exploitation:
  □ Replay attacks (if unencrypted)
  □ Protocol fuzzing
  □ Credential extraction
  □ Signal injection

Phase 5 - Reporting:
  □ Frequency documentation
  □ Protocol analysis
  □ Vulnerability assessment
  □ Mitigation recommendations
```

### Legal Considerations

⚠️ **Important:** RF testing has legal restrictions

| Consideration | Guidance |
|---------------|----------|
| **Transmission** | Only transmit on frequencies you're licensed for |
| **Interception** | Laws vary by country (generally OK for research) |
| **Replay Attacks** | Only on systems you own or have authorization to test |
| **Interference** | Never interfere with critical systems (aviation, emergency) |
| **Privacy** | Respect privacy laws when capturing signals |

### Activation

```
"Activate Sub-GHz SDR mode"
"Activate Sub-GHz SDR mode - analyze [protocol/device]"
"Activate Sub-GHz SDR mode - IoT security assessment"
"Activate Sub-GHz SDR mode - signal intelligence operation"
```

---

## 📶 WiFi Security Tester Agent

### Mission Statement

> "Map the airwaves, crack the keys, secure the wireless."

Specialized in wireless network security assessment, WPA/WPA2/WPA3 testing, enterprise WiFi analysis, and wireless intrusion detection.

### Core Capabilities

| Capability | Tools/Techniques | Output |
|------------|------------------|--------|
| **Wireless Recon** | AP discovery, client detection, signal mapping | Wireless network inventory |
| **Encryption Testing** | WEP, WPA, WPA2, WPA3 assessment | Encryption vulnerability report |
| **Enterprise Testing** | 802.1X, EAP, RADIUS analysis | Enterprise auth assessment |
| **Client Attacks** | Evil twin, KARMA, probe request analysis | Client vulnerability report |
| **Post-Connection** | Network pivoting, lateral movement | Internal network assessment |
| **Wireless IDS** | Rogue AP detection, attack detection | WIDS assessment |

### WiFi Security Standards

| Standard | Security | Status | Attack Vectors |
|----------|----------|--------|----------------|
| **WEP** | RC4, 64/128-bit | ❌ Broken | Fragmentation, chop-chop |
| **WPA** | TKIP, RC4 | ❌ Deprecated | TKIP attacks |
| **WPA2-Personal** | AES-CCMP, PSK | ⚠️ Vulnerable | PMKID, dictionary attacks |
| **WPA2-Enterprise** | AES-CCMP, 802.1X | ✅ Good (if configured) | EAP downgrade, credential theft |
| **WPA3-Personal** | SAE, 192-bit | ✅ Better | Dragonblood (some) |
| **WPA3-Enterprise** | 192-bit, 802.1X | ✅ Best | Minimal known |

### Attack Vectors

| Attack | Target | Tools | Success Rate |
|--------|--------|-------|--------------|
| **WEP Crack** | WEP networks | Aircrack-ng | ~100% (minutes) |
| **PMKID Attack** | WPA2-Personal | Hashcat, hcxdumptool | High (if weak password) |
| **4-Way Handshake** | WPA2-Personal | Aircrack-ng, Hashcat | Medium (dictionary) |
| **WPS Attack** | WPS-enabled AP | Reaver, Bully | High (if WPS enabled) |
| **Evil Twin** | WiFi clients | Airbase-ng, hostapd | High (user-dependent) |
| **KARMA** | Probe requests | Karma, MANA | Medium |
| **EAP Downgrade** | WPA2-Enterprise | Eaphammer | Medium |
| **Dragonblood** | WPA3 | Custom exploits | Low (specific configs) |

### Hardware Requirements

| Adapter | Chipset | Monitor Mode | Packet Injection | Price |
|---------|---------|--------------|------------------|-------|
| **Alfa AWUS036NHA** | Atheros AR9271 | ✅ | ✅ | $40 |
| **Alfa AWUS036ACS** | Realtek RTL8812AU | ✅ | ✅ | $50 |
| **Panda PAU09** | Ralink RT5572 | ✅ | ✅ | $30 |
| **TP-Link TL-WN722N** | Atheros (v1 only) | ✅ | ✅ | $20 |
| **Alfa AWUS1900** | Realtek RTL8814AU | ✅ | ✅ | $100 |

### Software Stack

| Tool | Purpose | Platform |
|------|---------|----------|
| **Aircrack-ng** | Capture, crack, inject | Linux/macOS/Windows |
| **Kismet** | Wireless IDS, detection | Linux/macOS |
| **Wireshark** | Packet analysis | Cross-platform |
| **hcxdumptool** | PMKID capture | Linux |
| **Hashcat** | Password cracking | Cross-platform |
| **Reaver/Bully** | WPS attacks | Linux |
| **Eaphammer** | Enterprise attacks | Linux |
| **Fluxion** | Evil twin automation | Linux |

### Testing Methodology

```
Phase 1 - Reconnaissance:
  □ Wireless survey (all bands: 2.4GHz, 5GHz, 6GHz)
  □ AP inventory (SSID, BSSID, channel, encryption)
  □ Client detection (probe requests, connected clients)
  □ Signal strength mapping
  □ Hidden SSID detection

Phase 2 - Passive Analysis:
  □ Capture management frames
  □ Identify WPS-enabled APs
  □ Detect PMKID availability
  □ Client behavior analysis
  □ Rogue AP baseline

Phase 3 - Active Testing:
  □ Deauthentication testing (if authorized)
  □ Handshake capture
  □ PMKID capture
  □ WPS testing
  □ Evil twin deployment (if authorized)

Phase 4 - Cracking:
  □ Wordlist attacks (rockyou, custom)
  □ Rule-based attacks
  □ Mask attacks
  □ PMKID cracking
  □ WPS PIN recovery

Phase 5 - Post-Exploitation:
  □ Network enumeration
  □ Lateral movement assessment
  □ Credential harvesting analysis
  □ Pivoting opportunities

Phase 6 - Reporting:
  □ Security posture assessment
  □ Vulnerability list with PoC
  □ Remediation recommendations
  □ Hardening guidelines
```

### Enterprise WiFi Testing

| Component | Testing Focus | Tools |
|-----------|---------------|-------|
| **802.1X** | EAP method security, certificate validation | Eaphammer, Wireshark |
| **EAP-TLS** | Certificate validation, mutual auth | Manual testing |
| **EAP-PEAP** | Credential protection, server validation | Eaphammer |
| **EAP-TTLS** | Inner auth method, tunnel security | Eaphammer |
| **RADIUS** | Server config, shared secrets, accounting | nmap, radtest |
| **Captive Portal** | Bypass techniques, credential handling | Manual testing |

### Common Findings

| Finding | Severity | Remediation |
|---------|----------|-------------|
| **WEP Encryption** | 🔴 Critical | Upgrade to WPA2/3 immediately |
| **WPA-TKIP** | 🔴 Critical | Disable TKIP, use AES only |
| **Weak PSK** | 🟠 High | Enforce strong passwords (20+ chars) |
| **WPS Enabled** | 🟠 High | Disable WPS |
| **No 802.1X** | 🟡 Medium | Implement enterprise auth for sensitive areas |
| **Weak EAP** | 🟠 High | Use EAP-TLS, disable PEAP-MSCHAPv2 |
| **Rogue APs** | 🟠 High | Deploy WIDS, regular surveys |
| **Open Networks** | 🟡 Medium | Require authentication, segment from internal |

### Activation

```
"Activate WiFi Security mode"
"Activate WiFi Security mode - audit [network/location]"
"Activate WiFi Security mode - enterprise assessment"
"Activate WiFi Security mode - rogue AP detection"
```

---

## Agent Integration Matrix

### How These Agents Work Together

| Scenario | Primary Agent | Supporting Agents |
|----------|---------------|-------------------|
| **Full App Pentest** | Web Pentesting | Bug Bounty (recon), Replay Attack (auth) |
| **Mobile App Security** | Bug Bounty | Reverse Engineering (native libs), Web Pentesting (API) |
| **IoT Assessment** | Sub-GHz SDR | WiFi Security, Reverse Engineering (firmware) |
| **Corporate Security** | WiFi Security | Red Team, Replay Attack (enterprise auth) |
| **Malware Analysis** | Reverse Engineering | Red Team (TTPs), Bug Bounty (IOCs) |
| **Bug Bounty Campaign** | Bug Bounty | Web Pentesting, Replay Attack |

### Mapping to Red/Blue/Purple Teams

| Agent | Team Alignment | Notes |
|-------|----------------|-------|
| Web Pentesting | 🔴 Red | Core offensive capability |
| Bug Bounty | 🔴 Red / 🟣 Purple | Offensive + disclosure coordination |
| Replay Attack | 🔴 Red | Specialized attack vector |
| Reverse Engineering | 🔴 Red / 🔵 Blue | Offensive + malware defense |
| Sub-GHz SDR | 🔴 Red | Specialized RF offensive |
| WiFi Security | 🔴 Red / 🔵 Blue | Offensive + wireless defense |

---

## Implementation Priority

| Priority | Agent | Rationale |
|----------|-------|-----------|
| **P1** | Web Pentesting | Most common engagement type |
| **P1** | Bug Bounty | High demand, monetization path |
| **P2** | WiFi Security | Common corporate assessment |
| **P2** | Replay Attack | Critical for auth/API security |
| **P3** | Reverse Engineering | Specialized, high-value |
| **P3** | Sub-GHz SDR | Niche, hardware-dependent |

---

## Tools Summary by Agent

### Web Pentesting
- Burp Suite Pro, OWASP ZAP, SQLmap, XSStrike, Ffuf, Nuclei

### Bug Bounty
- Subfinder, Amass, Ffuf, httpx, Nuclei, jwt_tool

### Replay Attack
- Burp Suite, jwt_tool, Impacket, Wireshark, OAuth tester

### Reverse Engineering
- Ghidra, IDA Pro, x64dbg, Frida, pwntools, binwalk

### Sub-GHz SDR
- RTL-SDR, HackRF, GNU Radio, URH, rtl_433, rfcat

### WiFi Security
- Aircrack-ng, Hashcat, Kismet, hcxdumptool, Eaphammer

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Next Review:** Quarterly  
**Owner:** Security Team
