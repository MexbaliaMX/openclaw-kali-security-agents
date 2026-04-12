# 🖥️ IT Engineer Agent

**Inspired by:** Network Chuck's OpenClaw demonstration  
**Created:** April 11, 2026  
**Status:** Ready for deployment

---

## Purpose

Act as an on-demand IT engineer for your Kali Linux system. Monitor resources, check security status, diagnose issues, and report findings via Telegram.

---

## Capabilities

### System Monitoring
- **CPU Usage** — Current load, top processes
- **Memory** — RAM usage, swap status
- **Disk** — Storage usage, inode count
- **Network** — Internet connectivity, speed test, open ports
- **Uptime** — System uptime, last boot

### Security Checks
- **Failed Logins** — Recent SSH/auth failures
- **Open Ports** — Listening services (Nmap/Netstat)
- **Firewall Status** — UFW/iptables rules
- **Last Logins** — Who logged in and when
- **Critical Logs** — Auth logs, syslog errors

### Diagnostics
- **Service Status** — Check if critical services are running
- **Process Analysis** — Find resource hogs
- **Network Troubleshooting** — DNS, routing, connectivity
- **Disk Health** — SMART status (if available)

---

## Activation Commands

### Quick Checks
```
"Check system health"
"Run IT diagnostics"
"Monitor server status"
"Security check"
```

### Specific Requests
```
"Check CPU and RAM usage"
"Show open ports"
"Any failed login attempts?"
"Run speed test"
"Check disk space"
"Who logged in recently?"
```

---

## Sample Output Format

```
🖥️ IT ENGINEER REPORT — April 11, 2026 14:58 EDT

━━━━━━━━━━━━━━━━━━━━━━
⚡ SYSTEM RESOURCES
━━━━━━━━━━━━━━━━━━━━━━
CPU: 23% (4 cores) — Top: firefox (12%)
RAM: 6.2GB / 16GB (39%) — Swap: 0.5GB used
Disk: 145GB / 256GB (57%) — Inodes: 12%

━━━━━━━━━━━━━━━━━━━━━━
🌐 NETWORK STATUS
━━━━━━━━━━━━━━━━━━━━━━
Internet: ✅ Connected (142 Mbps down / 38 Mbps up)
Open Ports: 22 (SSH), 80 (HTTP), 443 (HTTPS)
Firewall: ✅ Active (UFW)

━━━━━━━━━━━━━━━━━━━━━━
🔒 SECURITY CHECK
━━━━━━━━━━━━━━━━━━━━━━
Failed Logins (24h): 0 attempts
Last Login: kali @ pts/0 — April 11, 14:30 EDT
Critical Logs: ✅ No errors in last 6 hours

━━━━━━━━━━━━━━━━━━━━━━
⏱️ UPTIME
━━━━━━━━━━━━━━━━━━━━━━
System Up: 4 days, 7 hours
Last Boot: April 7, 2026 07:49 EDT

━━━━━━━━━━━━━━━━━━━━━━
✅ STATUS: HEALTHY
━━━━━━━━━━━━━━━━━━━━━━
```

---

## Implementation Notes

### Commands Used
```bash
# CPU/Memory
top -bn1 | head -20
free -h
vmstat 1 2

# Disk
df -h
df -i

# Network
speedtest-cli (or curl + speedtest.net API)
ss -tlnp
nmap -sT localhost

# Security
last -20
grep "Failed password" /var/log/auth.log | tail -10
systemctl status ssh
ufw status

# Uptime
uptime
who -b
```

### Required Tools
- `speedtest-cli` — Internet speed testing
- `nmap` — Port scanning
- `htop` or `top` — Process monitoring
- `ufw` — Firewall management

---

## Integration Options

### Option 1: Direct Prompt
Ask OpenClaw directly with natural language:
> "Act as an IT engineer. Check my system's CPU, RAM, disk, network, and security status. Give me a formatted report."

### Option 2: Custom Skill
Create a dedicated `it-engineer` skill with pre-built commands (recommended for frequent use).

### Option 3: Cron + Memory
Schedule periodic checks via heartbeat, store results in `memory/it-status.json`.

---

## Next Steps

1. **Test basic commands** on current Kali system
2. **Create skill** with reusable monitoring functions
3. **Add Telegram formatting** for clean output
4. **Optional:** Build dashboard agent for visual monitoring

---

**Related:**
- Network Chuck's OpenClaw Video: https://youtube.com/watch?v=T-HZHO_PQPY
- OpenClaw Dashboard Projects: https://github.com/theNetworkChuck/openclaw-setup
