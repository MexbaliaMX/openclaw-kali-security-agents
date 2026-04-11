# KaliKlaw Environment Setup

**Last Updated:** 2026-04-10  
**Host:** Kali Linux (kali@kali)  
**Platform:** Telegram → OpenClaw → KaliKlaw

---

## Installed Tools

### Android Pentesting
| Tool | Version | Location | Install Method |
|------|---------|----------|----------------|
| frida-tools | 14.8.1 | `~/.local/bin/frida` | pipx |
| objection | 1.12.4 | `~/.local/bin/objection` | pipx |
| apkid | 3.1.0 | `~/.local/bin/apkid` | pipx |
| jadx | 1.5.5 | `/usr/bin/jadx` | apt |
| apktool | 2.7.0 | `/usr/bin/apktool` | apt |
| aapt2 | — | `/usr/bin/aapt2` | apt (Android SDK) |

### Android SDK (Complete)
| Tool | Version | Location |
|------|---------|----------|
| adb | 34.0.5 | `/usr/bin/adb` |
| zipalign | — | `/usr/bin/zipalign` |
| apksigner | 0.9 | `/usr/bin/apksigner` |
| aapt2 | — | `/usr/bin/aapt2` |

---

## Skills Directory

```
~/.agents/skills/
├── android-apk-audit/       # DragonJAR Android Pentesting Skill
│   ├── SKILL.md
│   ├── assets/frida-scripts/
│   ├── scripts/
│   └── references/
└── agency-agents/           # 28 Specialized Agent Personas
    ├── specialized/
    ├── engineering/
    ├── testing/
    ├── product/
    └── ...
```

### Agent Activation
Say **"Activate [Agent] mode"** to embody a specific persona:
- `Activate Security Engineer mode`
- `Activate MCP Builder mode`
- `Activate Workflow Architect mode`
- `Activate Reality Checker mode`

See `TOOLS.md` for full agent catalog.

---

## Documentation

### MCP Security
| File | Purpose |
|------|---------|
| `docs/mcp-security/OWASP-MCP-Security-Guide-v1.0.pdf` | Original OWASP PDF |
| `docs/mcp-security/README.md` | Quick reference summary |
| `docs/mcp-security/Secure-MCP-Builder-Guide.md` | Full integration guide |

### Skills
| File | Purpose |
|------|---------|
| `TOOLS.md` | Agent catalog + local notes |
| `ENVIRONMENT.md` | This file — tool inventory |

---

## Memory Files

Daily session notes are stored in `memory/YYYY-MM-DD.md`:
- `memory/2026-04-10.md` — Current session notes

---

## Quick Commands

```bash
# Verify Android pentesting tools
frida --version
objection --version
apkid --version
jadx --version
apktool --version

# Check skills directory
ls -la ~/.agents/skills/

# View agent catalog
grep -A 50 "Specialized Agents" ~/TOOLS.md
```

---

## Session Startup Checklist

For new sessions, verify:

1. **Skills available:**
   ```bash
   ls ~/.agents/skills/
   ```

2. **Tools installed:**
   ```bash
   which frida objection apkid jadx apktool
   ```

3. **Memory loaded:**
   - Read `memory/YYYY-MM-DD.md` (today)
   - Read `TOOLS.md` (agent catalog)

4. **Documentation accessible:**
   ```bash
   ls docs/mcp-security/
   ```

---

*This file is auto-generated. Update when new tools or skills are installed.*
