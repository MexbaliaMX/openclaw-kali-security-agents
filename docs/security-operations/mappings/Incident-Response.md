# Incident Response - Kali Linux Tool Mapping

**Agent:** 🚨 Incident Response  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 42  
**Status:** Complete

---

## Overview

**Mission:** Lead incident response efforts including triage, containment, eradication, recovery, and lessons learned.

**Primary Use Cases:**
- Incident triage and classification
- Digital forensics (disk, memory, network)
- Live response and evidence collection
- Malware analysis and IOC extraction
- Incident documentation and reporting
- Post-incident remediation

**IR Phases (NIST SP 800-61):**
1. Preparation
2. Detection & Analysis
3. Containment, Eradication & Recovery
4. Post-Incident Activity

---

## 1. Live Response & Triage

### Live Data Collection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **velociraptor** | velociraptor | Live forensics | `velociraptor --config config.yaml hunt` |
| **grr** | grr (manual) | Remote response | Web interface + clients |
| **kape** | kape (Windows) | Triage collection | `KAPE.exe --tsource C: --tdest ./output` |
| **winpeas** | winpeas (manual) | Windows enumeration | `winPEASany.exe` |
| **linpeas** | linpeas (manual) | Linux enumeration | `./linpeas.sh` |
| **pslist** | sysinternals (Windows) | Process listing | `pslist.exe` |
| **psexec** | sysinternals (Windows) | Remote execution | `psexec.exe \\target cmd` |

### Velociraptor Usage Examples
```bash
# Start Velociraptor server
./velociraptor server --config server.config.yaml

# Deploy client
./velociraptor client --config client.config.yaml

# Run hunt
velociraptor --config server.config.yaml hunt \
  "SELECT * FROM processes WHERE name LIKE '%malware%'"

# Collect artifacts
velociraptor --config server.config.yaml collect \
  -n Windows.System.Triage \
  --client C.12345
```

### KAPE Triage Collection
```bash
# Full triage collection
KAPE.exe --tsource C: --tdest D:\evidence\KAPE --tflush true

# Specific modules
KAPE.exe --tsource C: --tdest D:\evidence --module KapeTriage

# With compression
KAPE.exe --tsource C: --tdest D:\evidence --zip true
```

---

## 2. Memory Forensics

### Memory Acquisition

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **avml** | avml (manual) | Linux memory dump | `avml memory.dump` |
| **lime** | lime (manual) | Linux memory capture | `insmod lime.kit "path=mem.dump"` |
| **winpmem** | winpmem (Windows) | Windows memory dump | `winpmem_64.exe memory.dmp` |
| **magnetramcapture** | magnet (Windows) | RAM capture | GUI application |
| **ftkimager** | ftkimager (manual) | Memory imaging | GUI application |

### Memory Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **volatility3** | volatility3 | Memory forensics | `volatility3 -f memory.dump windows.pslist` |
| **rekall** | rekall (pip) | Memory analysis | `rekall -f memory.dump pslist` |
| **memdump** | volatility3 | Process memory dump | `volatility3 -f mem.dump windows.malwareproc` |
| **yarascan** | volatility3 | YARA memory scanning | `volatility3 -f mem.dump windows.yarascan` |

### Volatility3 Commands
```bash
# System information
volatility3 -f memory.dump windows.info

# Process list
volatility3 -f memory.dump windows.pslist

# Process tree
volatility3 -f memory.dump windows.pstree

# Network connections
volatility3 -f memory.dump windows.netscan

# DLL list
volatility3 -f memory.dump windows.dlllist

# Registry hives
volatility3 -f memory.dump windows.registry.hivelist

# Command history
volatility3 -f memory.dump windows.cmdline

# Scheduled tasks
volatility3 -f memory.dump windows.scheduledtasks

# Malware detection (YARA)
volatility3 -f memory.dump windows.yarascan --yara-rules malware.yar

# Dump suspicious process
volatility3 -f memory.dump windows.dumpfile --pid 1234
```

---

## 3. Disk Forensics

### Disk Imaging

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dc3dd** | dc3dd | Forensic imaging | `dc3dd if=/dev/sda of=image.dd hash=sha256` |
| **ddrescue** | gddrescue | Data recovery | `ddrescue /dev/sda image.dd log.txt` |
| **guymager** | guymager | Disk imager | `guymager` (GUI) |
| **ftkimager** | ftkimager (manual) | Disk imaging | GUI application |
| **ewf-tools** | libewf-tools | EWF format | `ewfacquire /dev/sda` |
| **afflib** | afflib-tools | AFF format | `image_aff /dev/sda image.aff` |

### Disk Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **autopsy** | autopsy | Forensic platform | `autopsy` (GUI) |
| **sleuthkit** | sleuthkit | Forensic toolkit | `fls -r /dev/sda1` |
| **bulk-extractor** | bulk-extractor | Feature extraction | `bulk_extractor image.dd -o output/` |
| **plaso** | plaso | Timeline generation | `log2timeline.py timeline.plaso /mnt/evidence` |
| **photorec** | testdisk | File recovery | `photorec image.dd` |
| **testdisk** | testdisk | Partition recovery | `testdisk image.dd` |

### Sleuth Kit Commands
```bash
# List file system info
fsstat image.dd

# List files (recursive)
fls -r image.dd

# Recover file
icat image.dd 1234 > recovered_file

# Find deleted files
fls -d image.dd

# Search for string
srch_strings -f image.dd "password"

# Generate bodyfile for timeline
fls -m / image.dd > bodyfile

# Create timeline
mactime -b bodyfile -d > timeline.txt
```

### Autopsy Workflow
```
1. Create new case
2. Add data source (disk image)
3. Configure ingest modules:
   - File type identification
   - Keyword search
   - Hash lookup
   - Deleted file recovery
   - Web artifact analysis
   - Email analysis
4. Run ingest
5. Review findings
6. Export report
```

---

## 4. Network Forensics

### PCAP Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **wireshark** | wireshark | Protocol analyzer | `wireshark capture.pcap` (GUI) |
| **tshark** | wireshark | CLI packet analysis | `tshark -r capture.pcap -Y "http"` |
| **tcpdump** | tcpdump | Packet capture | `tcpdump -r capture.pcap` |
| **networkminer** | networkminer (manual) | Network forensics | GUI application |
| **xplico** | xplico (manual) | Network forensics | Web interface |
| **zeek** | zeek | Network analysis | `zeek -r capture.pcap local` |

### Tshark Examples
```bash
# Filter HTTP traffic
tshark -r capture.pcap -Y "http.request"

# Extract HTTP objects
tshark -r capture.pcap -Y "http" -T fields -e http.request.uri

# Find DNS queries
tshark -r capture.pcap -Y "dns.flags.response == 0" -T fields -e dns.qry.name

# Extract credentials
tshark -r capture.pcap -Y "http.authbasic" -T fields -e http.authorization

# Follow TCP stream
tshark -r capture.pcap -Y "tcp.stream == 1" -T fields -e data

# Export objects
tshark -r capture.pcap --export-objects http,output/
```

### Network Forensics Workflow
```
1. Capture traffic (if ongoing incident)
   tcpdump -i eth0 -w incident_capture.pcap

2. Identify suspicious IPs
   tshark -r capture.pcap -T fields -e ip.src | sort | uniq -c | sort -rn

3. Extract IOCs
   - DNS queries (C2 domains)
   - HTTP requests (malware downloads)
   - Suspicious ports

4. Reconstruct sessions
   tshark -r capture.pcap -q -z follow,tcp,ascii,filter

5. Export artifacts
   tshark -r capture.pcap --export-objects http,artifacts/
```

---

## 5. Timeline Analysis

### Timeline Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **plaso** | plaso | Timeline generation | `log2timeline.py timeline.plaso /evidence` |
| **timesketch** | timesketch (pip) | Timeline analysis | Web interface |
| **mactime** | sleuthkit | Timeline viewing | `mactime -b bodyfile` |
| **log2timeline** | plaso | Timeline creation | `log2timeline.py output.plaso /mnt/evidence` |
| **psort** | plaso | Timeline processing | `psort.py timeline.plaso -o dynamic` |

### Plaso/Timesketch Workflow
```bash
# Create timeline
log2timeline.py timeline.plaso /mnt/evidence

# Process timeline
psort.py timeline.plaso -o dynamic -o timeline.csv

# Import to Timesketch
tsctl importtimeline timeline.plaso --name "Incident Timeline"

# Query timeline (Timesketch)
# Web interface: http://localhost:5000
# Query: data_type:"fs:stat" AND filename:"malware.exe"
```

---

## 6. Malware Analysis (IR Context)

### Quick Malware Triage

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **file** | file | File type ID | `file suspicious.exe` |
| **strings** | binutils | String extraction | `strings suspicious.exe` |
| **floss** | floss (manual) | Advanced strings | `floss suspicious.exe` |
| **pefile** | pefile (pip) | PE analysis | `python3 -c "import pefile; pe=pefile.PE('file.exe')"` |
| **die** | die (manual) | Packer detection | `die suspicious.exe` |
| **exeinfo-pe** | exeinfo-pe (manual) | Packer detection | GUI application |
| **pestudio** | pestudio (manual) | PE analysis | GUI application |
| **capa** | capa (pip) | Capability detection | `capa suspicious.exe` |

### YARA Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **yara** | yara | Pattern matching | `yara -r rules/ suspicious/` |
| **yaragen** | yaragen (pip) | YARA generator | `yaragen -g malware` |
| **yara-python** | yara (pip) | Python integration | `import yara` |

### YARA Rule Example
```yara
rule Suspicious_Executable {
    meta:
        description = "Detects suspicious executable characteristics"
        author = "IR Team"
    strings:
        $mz = "MZ"
        $pe = "PE"
        $cmd1 = "cmd.exe"
        $cmd2 = "/c "
        $ps = "powershell"
    condition:
        $mz at 0 and $pe and ($cmd1 or $cmd2 or $ps)
}
```

---

## 7. IOC Extraction & Threat Intel

### IOC Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **iocextract** | iocextract (pip) | IOC extraction | `python3 iocextract.py < input.txt` |
| **ioc-fanger** | ioc-fanger (pip) | IOC normalization | `python3 ioc_fanger.py` |
| **misp** | misp (manual) | Threat intel platform | Web interface |
| **opencti** | opencti (manual) | CTI platform | Web interface |
| **virustotal** | virustotal (pip) | VT API | `vt file hash` |

### IOC Extraction Workflow
```bash
# Extract IOCs from text/email
python3 iocextract.py < incident_notes.txt > iocs.txt

# Extract from PCAP
tshark -r capture.pcap -T fields -e ip.src -e ip.dst | sort -u > ips.txt
tshark -r capture.pcap -Y "dns" -T fields -e dns.qry.name | sort -u > domains.txt

# Extract from memory dump
volatility3 -f memory.dump windows.netscan | awk '{print $4}' | sort -u >> ips.txt

# Validate IOCs with VirusTotal
vt file < hash.txt

# Upload to MISP
# Web interface or API
```

---

## 8. IR Case Management

### Case Management Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **thehive** | thehive (manual) | IR case management | Web interface |
| **cortex** | cortex (manual) | Analysis engine | Web interface |
| **rtir** | rtir | Incident response | Web interface |
| **incident-response** | ir (manual) | IR platform | Web interface |
| **dradis** | dradis (manual) | Collaboration | Web interface |

### TheHive Workflow
```
1. Create case
   - Title, description, severity
   - Assign to analyst

2. Add observables
   - IPs, domains, hashes, files
   - Auto-enrich with Cortex

3. Create tasks
   - Evidence collection
   - Analysis tasks
   - Containment actions

4. Document findings
   - Timeline
   - IOCs
   - TTPs (MITRE ATT&CK)

5. Generate report
   - Executive summary
   - Technical findings
   - Recommendations
```

---

## 9. Evidence Preservation

### Chain of Custody

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dc3dd** | dc3dd | Forensic imaging | `dc3dd if=/dev/sda of=image.dd hash=sha256 log=evidence.log` |
| **md5deep** | md5deep | Hashing | `md5deep -r evidence/ > hashes.txt` |
| **sha256deep** | md5deep | SHA256 hashing | `sha256deep -r evidence/` |
| **tar** | tar | Evidence archiving | `tar -czf evidence.tar.gz --exclude='*.tar.gz' evidence/` |
| **gpg** | gnupg | Evidence encryption | `gpg --encrypt --recipient ir@company.com evidence.tar.gz` |

### Evidence Handling Procedure
```
1. Document collection
   - Date/time
   - Collector name
   - System details
   - Hash values

2. Create forensic copy
   dc3dd if=/dev/sda of=/evidence/system_image.dd hash=sha256 log=hash.log

3. Verify hash
   sha256sum system_image.dd

4. Secure storage
   tar -czf evidence_001.tar.gz evidence/
   gpg --encrypt evidence_001.tar.gz

5. Chain of custody log
   - Who accessed
   - When
   - Why
```

---

## Top 10 IR Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Velociraptor** | Live Response | Remote triage at scale |
| 2 | **Volatility3** | Memory Forensics | Memory analysis framework |
| 3 | **Autopsy** | Disk Forensics | Complete forensic platform |
| 4 | **Wireshark** | Network Forensics | Protocol analysis |
| 5 | **Plaso/Timesketch** | Timeline | Timeline generation/analysis |
| 6 | **TheHive** | Case Mgmt | IR case management |
| 7 | **KAPE** | Triage | Fast Windows triage |
| 8 | **YARA** | Malware | Pattern matching |
| 9 | **dc3dd** | Imaging | Forensic disk imaging |
| 10 | **Sleuth Kit** | Forensics | File system analysis |

---

## Quick Reference Commands

### Initial Triage
```bash
# Process listing (live)
ps auxf > processes.txt
netstat -tulpn > network.txt
lsof -i > open_files.txt

# Quick memory dump (Linux)
python3 avml memory.dump

# Quick disk image
dc3dd if=/dev/sda of=/evidence/image.dd hash=sha256
```

### Memory Analysis
```bash
# Basic analysis
volatility3 -f memory.dump windows.info
volatility3 -f memory.dump windows.pslist
volatility3 -f memory.dump windows.netscan

# Malware hunting
volatility3 -f memory.dump windows.yarascan --yara-rules malware.yar
volatility3 -f memory.dump windows.cmdline | grep -i "powershell\|cmd"

# Extract suspicious files
volatility3 -f memory.dump windows.dumpfile --pid 1234
```

### Network Forensics
```bash
# Find C2 communication
tshark -r capture.pcap -Y "dns" -T fields -e dns.qry.name | sort | uniq -c | sort -rn

# Extract downloaded files
tshark -r capture.pcap --export-objects http,extracted/

# Find suspicious connections
tshark -r capture.pcap -Y "tcp.port == 4444 or tcp.port == 5555"
```

### Timeline Creation
```bash
# Create timeline from disk
log2timeline.py timeline.plaso /mnt/evidence

# Export to CSV
psort.py timeline.plaso -o csv -o timeline.csv

# Query timeline
tsctl importtimeline timeline.plaso --name "IR Timeline"
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Memory** | Volatility3, Rekall |
| **Disk** | Autopsy, Sleuth Kit, dc3dd, ddrescue |
| **Network** | Wireshark, Tcpdump, Zeek |
| **Timeline** | Plaso, Timesketch |
| **Analysis** | Yara, Strings, File |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Velociraptor** | Download binary | Live response |
| **KAPE** | Download from Erik Zimmerman | Windows triage |
| **TheHive/Cortex** | apt or Docker | Case management |
| **MISP** | apt + web setup | Threat intel |
| **OpenCTI** | Docker compose | CTI platform |
| **FTK Imager** | Download from AccessData | Imaging tool |
| **Pestudio** | Download from winitor | PE analysis |
| **NetworkMiner** | Download from Netresec | Network forensics |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Blue Team** | Receive alerts, escalate incidents |
| **Red Team** | Understand attacker TTPs |
| **Purple Team** | Improve detection based on incidents |
| **Threat Detection** | Share new IOCs, detection rules |
| **Reverse Engineering** | Malware analysis support |
| **Security Engineer** | Implement containment measures |

---

## IR Playbook Quick Reference

### Phishing Incident
```
1. Collect email (headers, attachments)
2. Analyze attachments (sandbox, YARA)
3. Check URLs (VirusTotal, URLScan)
4. Search for similar emails
5. Contain: Block sender, quarantine emails
6. Notify affected users
7. Document in TheHive
```

### Ransomware Incident
```
1. ISOLATE affected systems immediately
2. Identify ransomware variant
3. Check for decryption tools (NoMoreRansom)
4. Preserve evidence (memory, disk)
5. Identify patient zero
6. Assess backup status
7. Begin recovery from clean backups
8. Document everything
```

### Data Breach
```
1. Contain: Revoke access, isolate systems
2. Assess scope: What data was accessed?
3. Preserve evidence
4. Notify legal/compliance
5. Prepare customer notification
6. Engage external IR if needed
7. Post-incident: Improve controls
```

---

## IR Metrics & KPIs

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Time to Detect (TTD)** | <1 hour | Alert to triage start |
| **Time to Contain (TTC)** | <4 hours | Triage to containment |
| **Time to Eradicate (TTE)** | <24 hours | Containment to eradication |
| **Time to Recover (TTR)** | <48 hours | Eradication to recovery |
| **Evidence Integrity** | 100% | Hash verification pass rate |
| **Documentation Completeness** | 100% | Case file completeness |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
