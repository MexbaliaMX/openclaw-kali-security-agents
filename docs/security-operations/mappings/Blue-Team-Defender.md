# Blue Team Defender - Kali Linux Tool Mapping

**Agent:** 🔵 Blue Team Defender  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 72  
**Status:** Complete

---

## Overview

**Mission:** Protect assets through monitoring, detection, incident response, and security operations.

**Primary Use Cases:**
- Security Operations Center (SOC) operations
- Threat hunting and detection engineering
- Incident response and forensics
- Vulnerability management
- Security monitoring and alerting

**NIST CSF Alignment:** Detect, Respond, Recover, Protect, Identify

---

## 1. SIEM & Log Analysis

### SIEM Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **elasticsearch** | elasticsearch | Search engine | `curl -X GET "localhost:9200/_cluster/health"` |
| **logstash** | logstash | Log processing | `logstash -f config.conf` |
| **kibana** | kibana | Visualization | Web interface (5601) |
| **ossim** | ossim | SIEM platform | Web interface |
| **splunk** | splunk (manual) | Enterprise SIEM | Web interface (8089) |
| **graylog** | graylog (manual) | Log management | Web interface (9000) |
| **wazuh** | wazuh | Security monitoring | Web interface |

### Log Analysis Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **lnav** | lnav | Log file navigator | `lnav /var/log/*.log` |
| **multitail** | multitail | Multi-file tail | `multitail /var/log/syslog /var/log/auth.log` |
| **swatch** | swatch | Log watcher | `swatch -c swatchrc -t /var/log/auth.log` |
| **logwatch** | logwatch | Log analysis | `logwatch --detail high --mailto admin@company.com` |
| **goaccess** | goaccess | Web log analyzer | `goaccess access.log -o report.html` |
| **journalctl** | systemd | Systemd logs | `journalctl -f -u ssh` |

### Log Query Examples (Elasticsearch)
```bash
# Failed login attempts
curl -X GET "localhost:9200/logs-*/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match": { "message": "failed login" } },
  "size": 100
}'

# Brute force detection (multiple failures from same IP)
curl -X GET "localhost:9200/logs-*/_search" -H 'Content-Type: application/json' -d'
{
  "aggs": {
    "by_ip": {
      "terms": { "field": "source.ip" },
      "aggs": {
        "failures": { "filter": { "match": { "event.outcome": "failure" } } }
      }
    }
  }
}'
```

---

## 2. Network Monitoring & IDS/IPS

### Network IDS/IPS

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **suricata** | suricata | Network IDS/IPS | `suricata -c /etc/suricata/suricata.yaml -i eth0` |
| **snort** | snort | Network IDS | `snort -A console -q -c /etc/snort/snort.conf -i eth0` |
| **zeek** | zeek | Network analysis | `zeek -i eth0 local` |
| **securityonion** | securityonion (manual) | Security monitoring | Web interface |

### Packet Capture & Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **wireshark** | wireshark | Protocol analyzer | `wireshark -i eth0` (GUI) or `tshark -i eth0` |
| **tcpdump** | tcpdump | Packet capture | `tcpdump -i eth0 -w capture.pcap port 443` |
| **tshark** | wireshark | CLI packet analysis | `tshark -i eth0 -Y "http.request" -T fields -e http.host` |
| **ngrep** | ngrep | Network grep | `ngrep -d eth0 "password" port 80` |
| **tcpflow** | tcpflow | TCP flow capture | `tcpflow -i eth0 -c port 80` |
| **netsniff-ng** | netsniff-ng | Packet capture | `netsniff-ng --in eth0 --out capture.pcap` |

### Zeek Scripting Examples
```bash
# Start Zeek with custom scripts
zeek -i eth0 local detect-threats

# Extract files from network traffic
zeek -i eth0 extract-files

# Custom Zeek script for suspicious activity
zeek -i eth0 local suspicious-dns.zeek
```

---

## 3. Endpoint Detection & Response (EDR)

### Host-Based IDS

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **ossec** | ossec-hids | Host-based IDS | `/var/ossec/bin/ossec-control start` |
| **wazuh-agent** | wazuh-agent | Endpoint security | `systemctl start wazuh-agent` |
| **sysmon** | sysmon (Windows) | System monitoring | `Sysmon64.exe -accepteula -i config.xml` |
| **grr** | grr (manual) | Remote response | Web interface + clients |

### File Integrity Monitoring

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **aide** | aide | File integrity | `aide --init && aide --check` |
| **tripwire** | tripwire | File integrity | `tripwire --check` |
| **osquery** | osquery | System querying | `osqueryi "SELECT * FROM processes"` |
| **wazuh-fim** | wazuh | File integrity monitoring | Configured via Wazuh manager |

### Osquery Examples
```sql
-- Running processes
SELECT name, path, pid FROM processes;

-- Listening ports
SELECT pid, port, protocol FROM listening_ports;

-- Scheduled tasks
SELECT name, path FROM scheduled_tasks;

-- User accounts
SELECT username, uid, gid FROM users;

-- Browser history
SELECT url, title FROM chrome_history;
```

---

## 4. Threat Intelligence

### TIP Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **misp** | misp (manual) | Threat intel platform | Web interface |
| **opencti** | opencti (manual) | Cyber threat intel | Web interface |
| **anubis** | anubis (manual) | Threat intel | Web interface |
| **threatconnect** | threatconnect (manual) | TI platform | Web interface |

### IOC Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **yara** | yara | Pattern matching | `yara -r rules/ suspicious_file` |
| **iocextract** | iocextract (pip) | IOC extraction | `python3 iocextract.py < input.txt` |
| **ioc-fanger** | ioc-fanger (pip) | IOC normalization | `python3 ioc_fanger.py < input.txt` |
| **mactime** | sleuthkit | Timeline analysis | `mactime -d -b bodyfile` |

### YARA Rule Example
```yara
rule Suspicious_PowerShell {
    meta:
        description = "Detects suspicious PowerShell commands"
        author = "Blue Team"
    strings:
        $ps1 = "powershell" nocase
        $ps2 = "Invoke-Expression" nocase
        $ps3 = "DownloadString" nocase
    condition:
        all of them
}
```

---

## 5. Digital Forensics

### Disk Forensics

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **autopsy** | autopsy | Forensic platform | `autopsy` (GUI) |
| **sleuthkit** | sleuthkit | Forensic toolkit | `fls -r /dev/sda1` |
| **ftkimager** | ftkimager (manual) | Disk imaging | GUI application |
| **dc3dd** | dc3dd | Forensic imaging | `dc3dd if=/dev/sda of=image.dd hash=sha256` |
| **guymager** | guymager | Disk imager | `guymager` (GUI) |
| **ewf-tools** | libewf-tools | EWF format tools | `ewfacquire /dev/sda` |

### Memory Forensics

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **volatility** | volatility3 | Memory forensics | `volatility3 -f memory.dump windows.pslist` |
| **rekall** | rekall (pip) | Memory analysis | `rekall -f memory.dump pslist` |
| **lime** | lime (manual) | Memory acquisition | `insmod lime.kit "path=mem.dump format=lime"` |
| **avml** | avml (manual) | Linux memory | `avml memory.dump` |

### Volatility3 Commands
```bash
# System information
volatility3 -f memory.dump windows.info

# Process list
volatility3 -f memory.dump windows.pslist

# Network connections
volatility3 -f memory.dump windows.netscan

# DLL list
volatility3 -f memory.dump windows.dlllist

# Registry hives
volatility3 -f memory.dump windows.registry.hivelist

# Malware detection (YARA)
volatility3 -f memory.dump windows.yarascan --yara-rules malware.yar
```

### Timeline Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **plaso** | plaso | Timeline generation | `log2timeline.py timeline.plaso /mnt/evidence` |
| **timesketch** | timesketch (pip) | Timeline analysis | Web interface |
| **mactime** | sleuthkit | Timeline viewing | `mactime -b bodyfile -d` |
| **super-timeline** | plaso | Super timeline | `psort.py -o dynamic timeline.plaso` |

---

## 6. Incident Response

### IR Case Management

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **thehive** | thehive (manual) | IR case management | Web interface |
| **cortex** | cortex (manual) | Analysis engine | Web interface |
| **rtir** | rtir | Incident response | Web interface |
| **incus** | incus (manual) | IR platform | Web interface |

### Live Response

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **velociraptor** | velociraptor | Live forensics | `velociraptor --config config.yaml hunt` |
| **grr** | grr (manual) | Remote response | Web interface + clients |
| **kolide** | kolide (manual) | Endpoint visibility | Web interface |
| **kape** | kape (Windows) | Triage collection | `KAPE.exe --tsource C: --tdest ./output` |

### IR Evidence Collection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dd** | coreutils | Disk imaging | `dd if=/dev/sda of=image.dd bs=4M` |
| **dcfldd** | dcfldd | Forensic imaging | `dcfldd if=/dev/sda of=image.dd hash=sha256` |
| **rsync** | rsync | File collection | `rsync -avz /evidence/ /backup/` |
| **tar** | tar | Evidence archiving | `tar -czf evidence.tar.gz /collected/` |

---

## 7. Threat Hunting

### Hunting Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **velociraptor** | velociraptor | Endpoint hunting | `velociraptor hunt "SELECT * FROM processes"` |
| **osquery** | osquery | System querying | `osqueryi "SELECT * FROM processes WHERE name LIKE '%malware%'"` |
| **elastalert** | elastalert | Alerting for ES | `elastalert --rule rule_name.yaml` |
| **sigma** | sigma (pip) | Detection rules | `sigma convert -t splunk rule.yml` |

### Detection Rule Examples (Sigma)
```yaml
title: Suspicious PowerShell Download
id: 12345678-1234-1234-1234-123456789012
status: experimental
description: Detects PowerShell downloading content
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        Image|endswith: '\powershell.exe'
        CommandLine|contains:
            - 'DownloadString'
            - 'Invoke-WebRequest'
            - 'wget'
    condition: selection
level: medium
```

### Hunting Queries (Elasticsearch)
```bash
# Multiple failed logins
GET /logs-*/_search
{
  "query": {
    "bool": {
      "filter": [
        { "match": { "event.action": "login_failed" } },
        { "range": { "@timestamp": { "gte": "now-1h" } } }
      ]
    }
  },
  "aggs": {
    "by_user": { "terms": { "field": "user.name" } }
  }
}

# Suspicious process execution
GET /logs-*/_search
{
  "query": {
    "match_phrase": { "process.command_line": "powershell -enc" }
  }
}
```

---

## 8. Vulnerability Management

### Vulnerability Scanners

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **openvas** | openvas | Vulnerability scanner | `gvm-start` (GUI) |
| **greenbone** | greenbone | Vulnerability mgmt | Web interface |
| **nessus** | nessus (manual) | Vulnerability scanner | Web interface |
| **trivy** | trivy | Container/IaC scanner | `trivy image nginx:latest` |
| **clair** | clair | Container scanning | `clair-scanner alpine:latest` |

### Patch Management

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **unattended-upgrades** | unattended-upgrades | Auto updates | `dpkg-reconfigure unattended-upgrades` |
| **apt-listchanges** | apt-listchanges | Changelog viewer | Pre-installed with apt |
| **needrestart** | needrestart | Restart notifier | `needrestart` |

---

## 9. Malware Analysis

### Sandbox Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **cuckoo** | cuckoo (manual) | Malware sandbox | `cuckoo submit malware.exe` |
| **joebox** | joebox (manual) | Sandbox | Web interface |
| **anyrun** | anyrun (web) | Interactive sandbox | Web service |
| **remnux** | remnux (VM) | Malware analysis distro | Separate VM |

### Static Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **peframe** | peframe (pip) | PE analyzer | `peframe malware.exe` |
| **pestudio** | pestudio (manual) | PE analysis | GUI application |
| **strings** | binutils | String extraction | `strings malware.exe` |
| **floss** | floss (manual) | Advanced strings | `floss malware.exe` |
| **die** | die (manual) | Packer detector | `die malware.exe` |
| **exeinfo-pe** | exeinfo-pe (manual) | Packer detection | GUI application |

### Behavioral Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **procmon** | procmon (Windows) | Process monitoring | GUI application |
| **procexp** | procexp (Windows) | Process explorer | GUI application |
| **wireshark** | wireshark | Network analysis | `wireshark -i eth0` |
| **fakenet-ng** | fakenet-ng (manual) | Network simulation | `fakenet-ng` |
| **apimonitor** | apimonitor (manual) | API monitoring | GUI application |

---

## 10. Security Hardening

### Hardening Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **lynis** | lynis | Security auditing | `lynis audit system` |
| **openscap** | openscap | Compliance scanning | `oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis sds.xml` |
| **cis-cat** | cis-cat (manual) | CIS benchmarking | Java application |
| **tiger** | tiger | Security checker | `tiger` |
| **chkrootkit** | chkrootkit | Rootkit detection | `chkrootkit` |
| **rkhunter** | rkhunter | Rootkit hunter | `rkhunter --check` |

### Container Security

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **trivy** | trivy | Container scanner | `trivy image nginx:latest` |
| **docker-bench** | docker-bench-security | Docker security | `./docker-bench-security.sh` |
| **clair** | clair | Container scanning | `clair-scanner alpine:latest` |
| **falco** | falco | Runtime security | `falco --config falco_rules.yaml` |

---

## Top 10 Blue Team Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Wazuh** | SIEM/HIDS | Open-source security monitoring |
| 2 | **Elastic Stack** | SIEM | Log aggregation and analysis |
| 3 | **Wireshark** | Network | Protocol analysis |
| 4 | **Suricata** | IDS/IPS | Network threat detection |
| 5 | **Volatility3** | Forensics | Memory analysis |
| 6 | **Autopsy** | Forensics | Disk forensics platform |
| 7 | **YARA** | Threat Intel | Malware pattern matching |
| 8 | **Velociraptor** | IR/Hunting | Live response and hunting |
| 9 | **Sigma** | Detection | Detection rule standard |
| 10 | **Lynis** | Hardening | Security auditing |

---

## Quick Reference Commands

### SIEM Queries (Elasticsearch)
```bash
# Failed logins in last hour
curl -X GET "localhost:9200/logs-*/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "filter": [
        { "match": { "event.action": "failed_login" } },
        { "range": { "@timestamp": { "gte": "now-1h" } } }
      ]
    }
  }
}'

# Brute force detection
curl -X GET "localhost:9200/logs-*/_search" -H 'Content-Type: application/json' -d'
{
  "aggs": {
    "ips": {
      "terms": { "field": "source.ip" },
      "aggs": {
        "failures": { "filter": { "match": { "event.outcome": "failure" } } }
      }
    }
  },
  "size": 0
}'
```

### Incident Response
```bash
# Memory acquisition (Linux)
python3 avml memory.dump

# Disk imaging
dc3dd if=/dev/sda of=evidence.dd hash=sha256 log=evidence.log

# Live process collection
ps auxf > processes.txt
netstat -tulpn > network.txt

# Volatility analysis
volatility3 -f memory.dump windows.pslist
volatility3 -f memory.dump windows.netscan
```

### Threat Hunting
```bash
# Osquery - suspicious processes
osqueryi "SELECT name, path FROM processes WHERE path LIKE '%temp%' OR name LIKE '%mimikatz%'"

# YARA scanning
yara -r /usr/share/yara/rules/ /suspicious/directory/

# Sigma rule conversion
sigma convert -t splunk windows_suspicious_powershell.yml
```

### Network Monitoring
```bash
# Start Suricata
suricata -c /etc/suricata/suricata.yaml -i eth0 -D

# Zeek monitoring
zeek -i eth0 local

# Packet capture
tcpdump -i eth0 -w capture.pcap port 443

# Real-time analysis
tshark -i eth0 -Y "http.request" -T fields -e http.host -e http.request.uri
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Network** | Wireshark, Tcpdump, Suricata, Zeek |
| **Forensics** | Autopsy, Sleuth Kit, Volatility3, dc3dd |
| **Analysis** | Yara, Lynis, chkrootkit, rkhunter |
| **IR** | Osquery, Velociraptor |
| **Containers** | Trivy, Docker Bench |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Wazuh** | apt + config | Full deployment required |
| **Elastic Stack** | apt or Docker | Resource intensive |
| **Splunk** | Download from Splunk | Free up to 500MB/day |
| **MISP** | apt + web setup | Threat intel platform |
| **OpenCTI** | Docker compose | Modern TI platform |
| **TheHive** | apt or Docker | IR case management |
| **Cuckoo** | pip + config | Malware sandbox |
| **REMnux** | Separate VM | Malware analysis distro |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Red Team** | Receive TTPs for detection validation |
| **Purple Team** | Coordinate detection testing |
| **Incident Response** | Handoff escalated incidents |
| **Threat Detection** | Share detection rules, IOCs |
| **Threat Intelligence** | Consume and produce threat intel |
| **Security Engineer** | Implement security controls |

---

## KPIs & Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **MTTD (Mean Time to Detect)** | <1 hour | SIEM alert timestamps |
| **MTTR (Mean Time to Respond)** | <4 hours | Incident ticket timestamps |
| **False Positive Rate** | <10% | Alert accuracy analysis |
| **Coverage** | 100% critical assets | Asset inventory vs. monitored |
| **Patch Compliance** | >95% within SLA | Vulnerability scanner reports |
| **Detection Coverage** | >80% MITRE ATT&CK | Purple team validation |

---

## SOC Playbook Quick Reference

### Phishing Investigation
```
1. Extract email headers
2. Analyze attachments (sandbox)
3. Check URLs (VirusTotal, URLScan)
4. Search for similar emails
5. Contain if malicious
6. User notification
```

### Malware Incident
```
1. Isolate affected system
2. Capture memory (Volatility)
3. Collect artifacts (KAPE/velociraptor)
4. Analyze malware (YARA, sandbox)
5. Identify IOCs
6. Hunt for spread
7. Eradicate and recover
```

### Brute Force Attack
```
1. Identify source IP
2. Block at firewall
3. Reset compromised accounts
4. Enable MFA
5. Review authentication logs
6. Implement rate limiting
```

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
