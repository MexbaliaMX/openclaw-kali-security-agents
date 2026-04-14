# MEMORY.md - Long-Term Memory for KaliKlaw

**User:** Wulfrano Moreno (@wulmor)  
**Platform:** Telegram → Kali Linux  
**Timezone:** America/New_York  
**Model:** qwen/qwen3.5-plus

---

## 🎯 Active Projects

### Cybersecurity Knowledge Library (Started: April 10, 2026)

Building a comprehensive security documentation library with cross-border (US/Mexico) coverage:

**AI Security (4 docs):**
- OWASP MCP Security Guide v1.0 → `docs/mcp-security/`
- Secure MCP Builder Guide → `docs/mcp-security/`
- Microsoft AI Security & Zero Trust → `docs/ai-cybersecurity/`
- **Unified AI Security Framework** → `docs/ai-cybersecurity/` (synthesized from all sources)

**Policy/Compliance (4 docs):**
- Mexico National Cybersecurity Plan 2025 → `docs/cybersecurity-policy/`
- CERT-MX Manual Básico de Ciberseguridad para MiPyMEs → `docs/cybersecurity-policy/`
- FTC Cybersecurity for Small Business Basics → `docs/cybersecurity-policy/`
- AI & Cybersecurity (Spanish) → `docs/ai-cybersecurity/`

**Technical (2 docs):**
- Learning Kali Linux Security Testing → `docs/kali-linux-security-testing/`
- ENVIRONMENT.md → `~/ENVIRONMENT.md`

**Security Operations (20 docs):**
- **Red/Blue/Purple Team Agent Planning** → `docs/security-operations/` (April 10, 2026)
- **Specialized Security Agents (6)** → `docs/security-operations/Specialized-Security-Agents.md` (April 10, 2026)
- **Kali Linux Tool Mapping** → `docs/security-operations/Kali-Linux-Tool-Mapping.md` (150+ tools)
- **Kali Tool Mapping Expansion Plan** → `docs/security-operations/Kali-Tool-Mapping-Expansion-Plan.md`
- **✅ Phase 1 COMPLETE** - Red/Blue/Purple Team (3 docs, 205 tools)
- **✅ Phase 2 COMPLETE** - Core Security (5 docs, ~200 tools)
- **✅ Phase 3 COMPLETE** - Specialized (6 docs, ~130 tools)
- **✅ Remaining Agents Analysis** → `mappings/Remaining-Agents-Analysis.md` (29 agents analyzed)
- **✅ E2E Test Plan** → `Agent-Framework-E2E-Test-Plan.md` (12-week testing plan)
  - 7 phases: Activation, Tool Availability, Workflows, Integration, Performance, Security, Documentation
  - Test scripts, reporting templates, success criteria
- **✅ Phase 1 COMPLETE** - Agent Activation Testing (April 10, 2026)
  - 49/49 agents tested - 100% pass rate
  - Average response time: <1 second
  - Zero activation errors
  - Ready for Phase 2: Tool Availability Testing

**Key Insight:** 62% of attacks target human element (phishing) - per CERT-MX. Framework emphasizes data-centric Zero Trust over perimeter defenses.

---

## 🤖 Agent-First Mandate (April 14, 2026)

**Policy:** ALL tasks MUST leverage the Agents and Sub-Agents infrastructure.

**Rationale:**
- Agents provide consistency, audit trails, and domain expertise
- Manual execution without agents is deprecated
- Sub-agent orchestration enables complex, parallel workflows

**Documentation Updated:**
- `AGENTS.md` - Added Agent-First Mandate section
- `README.md` - Added Agent-First Workflow section

**Enforcement:** Future sessions should activate relevant agents before executing any security, engineering, or project tasks.

---

## 🛠️ Environment Configuration

### Skills Installed (April 10, 2026)

**Android Pentesting:**
- Location: `~/.agents/skills/android-apk-audit/`
- Tools: frida-tools 14.8.1, objection 1.12.4, apkid 3.1.0, jadx 1.5.5, apktool 2.7.0, adb 34.0.5
- Status: ✅ 16/16 tools verified - Ready for APK audits

**Agency-Agents:**
- Location: `~/.agents/skills/agency-agents/`
- Contains: 28 specialized agent personas + 12 Core Security agents
- Activation: Say "Activate [Agent] mode"

### Agent Modes Available

**Core Security (12):** Security Engineer, Incident Response, Code Reviewer, Threat Detection, SRE, Compliance Auditor, Technical Writer, Trend Researcher, Senior PM, Project Manager, Evidence Collector, Reality Checker

**Specialized (28):** MCP Builder, Blockchain Security Auditor, Workflow Architect, Cultural Intelligence Strategist, etc. (see TOOLS.md for full list)

**🔴🔵🟣 Security Operations (3) - Planned:**
- **Red Team Operator** - Offensive security, penetration testing, attack simulation
- **Blue Team Defender** - Defensive security, SOC operations, incident response, threat hunting
- **Purple Team Integrator** - Red+Blue collaboration, coverage validation, maturity assessments

**🎯 Specialized Security (6) - Planned:**
- **Web Pentesting** - OWASP Top 10, API security, business logic exploitation
- **Bug Bounty** - Recon methodology, coordinated disclosure, bounty optimization
- **Replay Attack** - Auth protocol analysis, session manipulation, JWT/crypto attacks
- **Reverse Engineering** - Binary analysis, malware RE, vulnerability discovery
- **Sub-GHz SDR** - RF analysis, IoT security, wireless protocol RE
- **WiFi Security** - WPA/WPA2/WPA3 testing, enterprise WiFi, wireless IDS

---

## 📋 Working Preferences

### Session Startup (Required)
1. Read SOUL.md - persona/identity
2. Read USER.md - user context
3. Read memory/YYYY-MM-DD.md - recent session notes
4. **If main session:** Also read MEMORY.md (this file)

### Communication Style
- Platform: Telegram (markdown limited, no tables)
- Voice: Methodical, security-minded, calm competence (🥷 KaliKlaw)
- Language: English primary, Spanish docs available
- Format: Bullet lists over tables for Telegram compatibility

### Security Posture
- Destructive commands: Ask first
- External actions (email, public posts): Ask first
- Internal actions (read, organize, analyze): Proceed with discretion
- Prefer `trash` over `rm` for file deletion

---

## 🔑 Key Security Insights (To Remember)

### AI Security Principles
1. **Data-centric security** - Protect data wherever it lives (not perimeter-based)
2. **Shared responsibility** - Understand what AI provider secures vs. what you secure
3. **Zero Trust required** - MFA, least privilege, micro-segmentation for AI tools
4. **Human factor critical** - 62% of attacks are phishing (CERT-MX)
5. **Dynamic outputs** - Traditional security controls don't work for non-deterministic AI

### SME Security Priorities (US/Mexico Alignment)
| Priority | FTC (US) | CERT-MX (Mexico) |
|----------|----------|------------------|
| #1 | Employee training | Phishing awareness (62%) |
| #2 | MFA enforcement | Human resources = weakest link |
| #3 | Data encryption | 12 tactical security areas |
| #4 | Breach response plan | Incident response procedures |
| Framework | NIST CSF (5 functions) | National Plan 2025 |

---

## 📅 Important Dates

- **April 10, 2026:** Session started, cybersecurity library created, Unified AI Security Framework synthesized
- **July 10, 2026:** Quarterly review of Unified AI Security Framework (next review date)

---

## 🔗 Quick Reference

### File Locations
```
Workspace: /home/kali/.openclaw/workspace/
Skills:    ~/.agents/skills/
Docs:      /home/kali/.openclaw/workspace/docs/
Memory:    /home/kali/.openclaw/workspace/memory/
```

### Activation Commands
```
"Activate Security Engineer mode" - Threat modeling, audits
"Activate MCP Builder mode" - AI tool development
"Activate Compliance Auditor mode" - Gap assessments
"Activate Incident Response mode" - IR playbooks
```

### Related Files
- `TOOLS.md` - Agent catalog, environment specifics
- `SOUL.md` - Persona/identity
- `USER.md` - User context
- `memory/YYYY-MM-DD.md` - Daily session logs
- `docs/ai-cybersecurity/Unified-AI-Security-Framework.md` - Master framework

---

## 📝 Notes for Future Sessions

- User is building security expertise with focus on AI security + compliance
- Cross-border perspective (US/Mexico) is important
- Practical, actionable guidance preferred over theory
- Framework is ready for implementation - 24-week roadmap available
- Android pentesting environment is prepped and ready
- 40 agent modes available for specialized tasks

---

**Last Updated:** April 10, 2026  
**Next Review:** During next heartbeat check (update if new projects start)
