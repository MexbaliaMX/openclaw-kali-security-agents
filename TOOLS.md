# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

---

## 🥷 KaliKlaw Agents

Specialized agent modes adapted from agency-agents. Activate by saying "Activate [Agent] mode":

### Core Security & Engineering
| Agent | Purpose |
|-------|--------|
| 🔒 Security Engineer | Threat modeling, security audits, secure architecture |
| 🚨 Incident Response | Incident management, post-mortems, runbooks |
| 👁️ Code Reviewer | Security-focused code reviews |
| 🎯 Threat Detection | SIEM rules, MITRE ATT&CK, threat hunting |
| 🛡️ SRE | SLOs, observability, toil reduction |
| 📋 Compliance Auditor | SOC 2, ISO 27001, HIPAA, PCI-DSS readiness & gap assessments |
| 📚 Technical Writer | README files, API docs, tutorials, documentation audits |
| 🔭 Trend Researcher | Market intelligence, emerging trends, competitive analysis, opportunity assessments |
| 📊 Senior Project Manager | Complex programs, steering committees, multi-team coordination, executive reporting |
| 📋 Project Manager | Day-to-day execution, sprint coordination, task tracking, team facilitation |
| 📸 Evidence Collector | QA testing with visual proof, interactive element testing, spec compliance verification |
| 🧐 Reality Checker | Final integration testing, deployment readiness, end-to-end user journey validation |

### 🎭 Specialized Agents (28)
| Agent | Purpose |
|-------|--------|
| 🗺️ Workflow Architect | Workflow tree mapping, failure modes, handoff contracts |
| 🔌 MCP Builder | Model Context Protocol servers, custom AI tool development |
| 🛡️ Blockchain Security Auditor | Smart contract audits, DeFi vulnerability detection, exploit analysis |
| 📊 Compliance Auditor | Regulatory compliance, audit readiness, gap assessments |
| 🤖 Agents Orchestrator | Multi-agent coordination, task delegation, workflow routing |
| 🏛️ Automation Governance Architect | Automation policy, guardrails, compliance frameworks |
| 🔐 Agentic Identity Trust | Identity verification, trust systems, authentication flows |
| 💼 Accounts Payable Agent | AP automation, invoice processing, payment workflows |
| 📈 Data Consolidation Agent | Data aggregation, ETL pipelines, unified reporting |
| 🏥 Healthcare Marketing Compliance | HIPAA-compliant marketing, healthcare advertising regulations |
| 🏢 Government Digital Presales Consultant | Public sector tech sales, RFP responses, compliance mapping |
| 🕸️ Identity Graph Operator | Identity resolution, entity linking, graph analysis |
| 💻 LSP Index Engineer | Language Server Protocol, IDE tooling, developer experience |
| 👥 Recruitment Specialist | Hiring workflows, candidate evaluation, talent acquisition |
| 📑 Report Distribution Agent | Report generation, scheduling, multi-channel delivery |
| 💰 Sales Data Extraction Agent | CRM data mining, pipeline analysis, revenue intelligence |
| 🏗️ Civil Engineer | Infrastructure design, construction workflows, regulatory compliance |
| 🌍 Cultural Intelligence Strategist | Cross-cultural business strategy, localization, market adaptation |
| 📣 Developer Advocate | DevRel, technical content, community engagement, API docs |
| 📄 Document Generator | Document automation, template systems, bulk generation |
| 🇫🇷 French Consulting Market | French business consulting, market entry, regulatory navigation |
| 🇰🇷 Korean Business Navigator | Korean market entry, business culture, partnership facilitation |
| 🧠 Model QA | ML model testing, evaluation frameworks, quality assurance |
| ☁️ Salesforce Architect | Salesforce design, integration, Apex/Lightning development |
| 🎓 Study Abroad Advisor | International education, visa processes, program selection |
| 📦 Supply Chain Strategist | Supply chain optimization, risk mitigation, vendor management |
| 🔐 ZK Steward | Zero-knowledge proof systems, privacy-preserving protocols |

---

## 🛠️ Installed Skills (April 10, 2026)

### Android Pentesting (`android-apk-audit`)
**Location:** `~/.agents/skills/android-apk-audit/`

**Tools Installed:**
- `frida-tools` 14.8.1 (pipx)
- `objection` 1.12.4 (pipx)
- `apkid` 3.1.0 (pipx)
- `jadx` 1.5.5 (Kali default)
- `apktool` 2.7.0 (Kali default)
- `aapt2` (Kali default)
- `adb` 34.0.5 (Android SDK)
- `zipalign` (Android SDK)
- `apksigner` 0.9 (Android SDK)

**Status:** ✅ 16/16 tools verified — Ready for APK audits

### Agency-Agents (`agency-agents`)
**Location:** `~/.agents/skills/agency-agents/`

**Contains:**
- 28 specialized agent personas
- 12 Core Security & Engineering agents
- Full catalog added to this file (see tables above)

**Activation:** Say "Activate [Agent] mode"

---

## 📁 Skills Directory Structure

```
~/.agents/skills/
├── android-apk-audit/    # Android APK security auditing (DragonJAR)
└── agency-agents/        # 40 specialized agent personas
```

---

## 🔐 Unified AI Security Framework

**Location:** `docs/ai-cybersecurity/Unified-AI-Security-Framework.md`

**Key Principles:**
1. Data-centric security (not perimeter-based)
2. Shared responsibility with AI providers
3. Zero Trust architecture required
4. Human factor critical (62% phishing)
5. Dynamic outputs need new controls

**Implementation:** 24-week roadmap (3 phases)
**Next Review:** July 10, 2026

---

## 🔴🔵🟣 Red Team / Blue Team / Purple Team

**Planning Doc:** `docs/security-operations/Red-Blue-Purple-Team-Agents.md`

### 🔴 Red Team Operator (Offensive)
**Activation:** `"Activate Red Team mode"`

**Mission:** Simulate real-world attackers to find vulnerabilities before adversaries do.

**Core Capabilities:**
- Reconnaissance (OSINT, subdomain enumeration)
- Vulnerability assessment (Nmap, Nessus, web scanners)
- Exploitation (Metasploit, web app attacks, password attacks)
- Post-exploitation (privilege escalation, lateral movement)
- Social engineering (phishing, vishing)
- Physical security testing (if authorized)

**Tools:** Android pentesting skill, Burp Suite, Metasploit, Nmap, Hashcat, Aircrack-ng

**MITRE ATT&CK:** Full spectrum testing (Initial Access → Impact)

**Deliverables:** Executive summary, technical report, evidence package, remediation roadmap

---

### 🔵 Blue Team Defender (Defensive)
**Activation:** `"Activate Blue Team mode"`

**Mission:** Protect assets through monitoring, detection, incident response, and security operations.

**Core Capabilities:**
- Security monitoring (SIEM, EDR, network sensors)
- Threat intelligence (open source, commercial feeds)
- Incident response (playbooks, forensics, containment)
- Threat hunting (hypothesis-driven searches)
- Vulnerability management (scanning, patch coordination)
- Security engineering (firewall rules, hardening)

**Tools:** Splunk/ELK, CrowdStrike/SentinelOne, Snort/Suricata, Autopsy, Velociraptor

**NIST CSF Alignment:** Detect, Respond, Recover, Protect, Identify

**KPIs:** MTTD <1hr (critical), MTTR <4hrs (critical), <10% false positive rate, >95% patch compliance

---

### 🟣 Purple Team Integrator (Collaborative)
**Activation:** `"Activate Purple Team mode"`

**Mission:** Maximize security ROI through Red+Blue collaboration and continuous validation.

**Core Capabilities:**
- Collaboration facilitation (joint exercises, shared tooling)
- Attack simulation coordination (CALDERA, Atomic Red Team)
- Detection engineering (TTPs → detection rules)
- Security control validation (tool efficacy testing)
- Knowledge transfer (training, documentation)
- Metrics & reporting (coverage dashboards, maturity scores)

**Tools:** CALDERA, Atomic Red Team, MITRE ATT&CK Navigator, Sigma rules, dashboards

**Maturity Model:** Level 1 (Initial) → Level 5 (Optimized)

**Deliverables:** Coverage dashboard, detection efficacy reports, maturity assessments, rule packages

---

### Team Integration

| Scenario | Red | Blue | Purple |
|----------|-----|------|--------|
| New threat emerges | Simulate TTPs | Update detections | Validate & transfer |
| Tool deployment | Test efficacy/bypass | Configure/operate | Measure ROI |
| Incident response | Attacker perspective | Lead containment | Document lessons |
| Compliance audit | Control testing | Operational evidence | Framework mapping |

**Coverage Target:** >80% MITRE ATT&CK technique detection
**Current Baseline:** ~74% (per planning doc)

---

## 🎯 Specialized Security Agents (6) - Planned

**Planning Doc:** `docs/security-operations/Specialized-Security-Agents.md`

### 🌐 Web Pentesting Agent
**Activation:** `"Activate Web Pentesting mode"`

**Mission:** OWASP Top 10, API security, business logic exploitation

**Tools:** Burp Suite, OWASP ZAP, SQLmap, XSStrike, Ffuf, Nuclei, Arjun

**Focus Areas:**
- OWASP Top 10 2021 (all categories)
- API security (REST, GraphQL)
- Business logic flaws, IDOR, auth bypass
- Client-side (XSS, CSP, prototype pollution)
- Server-side (SSTI, deserialization, SSRF)

**Deliverables:** Technical report, PoC evidence, CVSS ratings, remediation guide

---

### 💰 Bug Bounty Agent
**Activation:** `"Activate Bug Bounty mode"`

**Mission:** Coordinated disclosure, recon methodology, bounty optimization

**Tools:** Subfinder, Amass, Ffuf, httpx, Nuclei, jwt_tool, LinkFinder

**Platforms:** HackerOne, Bugcrowd, Intigriti, YesWeHack, direct programs

**Recon Levels:**
- Level 1: Passive (subdomains, DNS, archives, GitHub)
- Level 2: Active (brute-forcing, scanning, crawling)
- Level 3: Deep (JS analysis, API enum, change detection)

**High-Value Targets:** RCE ($5K-50K), SQLi ($2K-15K), SSRF ($2K-20K), ATO ($2K-25K)

---

### 🔁 Replay Attack Agent
**Activation:** `"Activate Replay Attack mode"`

**Mission:** Authentication protocol analysis, session manipulation, cryptographic attacks

**Tools:** Burp Suite, jwt_tool, Impacket, Wireshark, SAML Raider, OAuth tester

**Attack Vectors:**
- JWT attacks (alg confusion, none alg, key confusion)
- Session replay, fixation, hijacking
- OAuth/SAML flow abuse
- Kerberos/NTLM (pass-the-hash/ticket)
- API replay, timestamp bypass, nonce reuse

**Common Targets:** API auth, session management, payment systems, 2FA, webhooks

---

### 🔍 Reverse Engineering Specialist
**Activation:** `"Activate Reverse Engineering mode"`

**Mission:** Binary analysis, decompilation, malware RE, vulnerability discovery

**Tools:** Ghidra, IDA Pro, x64dbg, Frida, pwntools, binwalk, ANY.RUN

**Analysis Types:**
- Static RE (disassembly, decompilation)
- Dynamic RE (debugging, instrumentation)
- Malware analysis (behavioral, IOC extraction)
- Firmware RE (embedded, IoT)

**Targets:** Windows/Linux binaries, Android/iOS apps, firmware, drivers, libraries

---

### 📡 Sub-GHz SDR Specialist
**Activation:** `"Activate Sub-GHz SDR mode"`

**Mission:** RF analysis, IoT security, wireless protocol reverse engineering

**Hardware:** RTL-SDR ($25), HackRF One ($300), YARD Stick One ($100), Flipper Zero ($200)

**Software:** GNU Radio, URH, Inspectrum, rtl_433, rfcat, GQRX

**Protocols:** ASK/OOK, FSK, Rolling Code, Z-Wave, Zigbee, LoRa, EnOcean, KEELOQ

**Targets:** Garage doors, car remotes, smart home, IoT sensors, access control, industrial IoT

**⚠️ Legal:** Only transmit on licensed frequencies, test only authorized systems

---

### 📶 WiFi Security Tester
**Activation:** `"Activate WiFi Security mode"`

**Mission:** Wireless network assessment, WPA/WPA2/WPA3 testing, enterprise WiFi

**Hardware:** Alfa AWUS036NHA, AWUS036ACS, Panda PAU09 (monitor mode + injection)

**Tools:** Aircrack-ng, Hashcat, Kismet, hcxdumptool, Eaphammer, Reaver, Fluxion

**Testing:**
- Encryption: WEP (broken), WPA-TKIP (deprecated), WPA2/3-Personal, WPA2/3-Enterprise
- Attacks: PMKID, 4-way handshake, WPS, evil twin, KARMA, EAP downgrade
- Enterprise: 802.1X, EAP-TLS/PEAP/TTLS, RADIUS, captive portal

**Common Findings:** WEP/TKIP usage, weak PSK, WPS enabled, rogue APs, weak EAP methods

---

### Specialized Agent Integration

| Scenario | Primary | Supporting |
|----------|---------|------------|
| Full app pentest | Web Pentesting | Bug Bounty, Replay Attack |
| Mobile app security | Bug Bounty | Reverse Engineering, Web Pentesting |
| IoT assessment | Sub-GHz SDR | WiFi Security, Reverse Engineering |
| Corporate security | WiFi Security | Red Team, Replay Attack |
| Malware analysis | Reverse Engineering | Red Team, Bug Bounty |
| Bug bounty campaign | Bug Bounty | Web Pentesting, Replay Attack |

---

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → `<internal-ip>`, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
