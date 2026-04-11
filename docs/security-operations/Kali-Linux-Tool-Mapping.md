# Kali Linux Tool Mapping for Specialized Security Agents

**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Kali Version:** 2026.1 (latest)  
**Purpose:** Map Kali Linux tools to each specialized security agent's capabilities

---

## Overview

This document maps **Kali Linux pre-installed tools** to each of the 6 specialized security agents, providing ready-to-use toolchains for immediate deployment.

### Kali Linux Tool Categories

| Category | Tool Count | Relevance |
|----------|------------|-----------|
| Information Gathering | 80+ | All agents |
| Vulnerability Analysis | 30+ | Web Pentesting, Bug Bounty |
| Web Applications | 50+ | Web Pentesting, Bug Bounty |
| Password Attacks | 25+ | Replay Attack, WiFi Security |
| Wireless Attacks | 30+ | WiFi Security, Sub-GHz SDR |
| Reverse Engineering | 40+ | Reverse Engineering |
| Exploitation Tools | 20+ | Red Team, Web Pentesting |
| Sniffing & Spoofing | 25+ | Replay Attack, WiFi Security |
| Post Exploitation | 15+ | Red Team |
| Forensics | 30+ | Reverse Engineering, Incident Response |
| Reporting | 10+ | All agents |

---

## 🌐 Web Pentesting Agent - Kali Tools

### Reconnaissance & Discovery

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **gobuster** | gobuster | Directory/DNS brute-forcing | `gobuster dir -u http://target -w /usr/share/wordlists/dirb/common.txt` |
| **ffuf** | ffuf | Web fuzzer | `ffuf -w /usr/share/wordlists/dirb/common.txt -u http://target/FUZZ` |
| **dirb** | dirb | Web content scanner | `dirb http://target /usr/share/wordlists/dirb/common.txt` |
| **nikto** | nikto | Web server scanner | `nikto -h http://target` |
| **whatweb** | whatweb | Website fingerprinting | `whatweb http://target` |
| **wapiti** | wapiti | Web app vulnerability scanner | `wapiti http://target -o report.html` |
| **skipfish** | skipfish | Web app security scanner | `skipfish -o ./report http://target` |
| **xray** | xray (manual install) | Advanced web scanner | `xray webscan --basic-crawler http://target` |

### Subdomain Enumeration

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **subfinder** | subfinder | Subdomain discovery | `subfinder -d target.com -o subs.txt` |
| **amass** | amass | In-depth attack surface mapping | `amass enum -d target.com -o subs.txt` |
| **theharvester** | theharvester | Email/subdomain harvesting | `theharvester -d target.com -l 500 -b google` |
| **maltego** | maltego | OSINT/visual link analysis | GUI application |
| **recon-ng** | recon-ng | Web reconnaissance framework | `recon-ng` (interactive) |

### SQL Injection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **sqlmap** | sqlmap | Automatic SQL injection | `sqlmap -u "http://target/page?id=1" --dbs` |
| **nosqlmap** | nosqlmap | NoSQL database hacking | `python3 nosqlmap.py` |
| **bsqlbf** | bsqlbf | Blind SQL injection brute-forcer | `bsqlbf.pl [options]` |

### XSS (Cross-Site Scripting)

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **xsstrike** | xsstrike (pip) | XSS detection suite | `python3 xsstrike.py -u "http://target/search?q=test"` |
| **dalfox** | dalfox (go) | XSS parameter analysis | `dalfox url "http://target/search?q=FUZZ"` |
| **xsser** | xsser | XSS exploitation framework | `xsser --url="http://target" --params="q"` |

### API Security

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **postman** | postman (manual) | API testing | GUI application |
| **insomnia** | insomnia (manual) | API client | GUI application |
| **kiterunner** | kiterunner | API route discovery | `kr scan http://target -A api` |
| **arjun** | arjun | HTTP parameter discovery | `arjun -u http://target/page` |
| **paramspider** | paramspider | Parameter discovery | `python3 paramspider.py -d target.com` |
| **inql** | inql (burp extension) | GraphQL scanner | Burp Suite extension |

### Fuzzing & Input Validation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **wfuzz** | wfuzz | Web fuzzer | `wfuzz -w wordlist.txt http://target/FUZZ` |
| **radamsa** | radamsa | Mutation fuzzer | `radamsa input.txt -o output/` |
| **american-fuzzy-lop** | afl++ | Coverage-guided fuzzer | `afl-fuzz -i input -o output ./target` |

### Vulnerability Scanners

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **nuclei** | nuclei | Template-based scanner | `nuclei -u http://target -o report.txt` |
| **openvas** | openvas | Full vulnerability scanner | `gvm-start` (GUI) |
| **vulnscan** | vulnscan | Web vulnerability scanner | `vulnscan http://target` |

### SSL/TLS Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **sslscan** | sslscan | SSL/TLS scanner | `sslscan target.com` |
| **sslyze** | sslyze | SSL configuration analyzer | `sslyze target.com` |
| **testssl.sh** | testssl.sh | TLS/SSL testing | `testssl.sh target.com` |
| **openssl** | openssl | SSL/TLS toolkit | `openssl s_client -connect target:443` |

### Session & Cookie Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **cookie-cadger** | cookie-cadger | Cookie analysis | GUI application |
| **burpsuite** | burpsuite (community/pro) | Web proxy/scanner | GUI application |

### Wordlists (Kali)

| Location | Content |
|----------|---------|
| `/usr/share/wordlists/dirb/` | Web directory lists |
| `/usr/share/wordlists/dirbuster/` | Directory brute-force lists |
| `/usr/share/wordlists/sqlmap/` | SQL injection payloads |
| `/usr/share/wordlists/fuzzdb/` | Fuzzing database |
| `/usr/share/wordlists/seclists/` | Comprehensive security lists |

---

## 💰 Bug Bounty Agent - Kali Tools

### Asset Discovery

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **subfinder** | subfinder | Fast subdomain discovery | `subfinder -d target.com -silent | sort -u` |
| **amass** | amass | Comprehensive enumeration | `amass enum -passive -d target.com` |
| **assetfinder** | assetfinder | Domain/subdomain finder | `assetfinder target.com` |
| **findomain** | findomain | Multi-source subdomain finder | `findomain -t target.com` |
| **sublist3r** | sublist3r | Subdomains via search engines | `python3 sublist3r.py -d target.com` |

### Content Discovery

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **ffuf** | ffuf | Fast web fuzzer | `ffuf -w wordlist.txt -u http://target/FUZZ` |
| **gobuster** | gobuster | Directory/DNS brute-forcer | `gobuster dir -u http://target -w wordlist.txt` |
| **feroxbuster** | feroxbuster | Recursive content discovery | `feroxbuster -u http://target` |
| **dirsearch** | dirsearch | Web path scanner | `dirsearch -u http://target` |
| **kiterunner** | kiterunner | Context-aware content discovery | `kr scan http://target` |

### Technology Fingerprinting

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **whatweb** | whatweb | Web technology identifier | `whatweb http://target` |
| **wappalyzer** | wappalyzer (browser ext) | Tech stack detection | Browser extension |
| **builtwith** | builtwith (manual) | Technology profiler | Web-based |
| **httpx** | httpx | HTTP toolkit | `httpx -l domains.txt -title -tech-detect` |

### JavaScript Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **linkfinder** | linkfinder (pip) | JS endpoint discovery | `python3 linkfinder.py -i http://target/app.js` |
| **secretfinder** | secretfinder (pip) | Secret discovery in JS | `python3 secretfinder.py -i app.js` |
| **jsfscan** | jsfscan (manual) | JavaScript scanner | `python3 jsfscan.py -u http://target` |
| **gauplus** | gauplus | Fetch URLs from Wayback | `gauplus target.com` |

### Wayback/Archive Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **waybackurls** | waybackurls (go) | Fetch Wayback Machine URLs | `waybackurls target.com` |
| **gau** | gau | Get all known URLs | `gau target.com` |
| **archiveroo** | archiveroo (manual) | Archive analysis | Python script |

### Vulnerability Detection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **nuclei** | nuclei | Template-based scanning | `nuclei -l urls.txt -t vulnerabilities/` |
| **dalfox** | dalfox | XSS scanner | `dalfox file urls.txt` |
| **sqlmap** | sqlmap | SQL injection testing | `sqlmap -m urls.txt --batch` |
| **xsstrike** | xsstrike | XSS detection suite | `python3 xsstrike.py -l urls.txt` |

### Screenshot & Visual Recon

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **aquatone** | aquatone (go) | Domain screenshot tool | `cat domains.txt | aquatone -out screenshots` |
| **eyewitness** | eyewitness | Website screenshot tool | `python3 eyewitness.py -x urls.txt` |
| **httpx** | httpx | With screenshot option | `httpx -l domains.txt -screenshot` |

### Port Scanning

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **nmap** | nmap | Network mapper | `nmap -sV -sC -oA scan target.com` |
| **masscan** | masscan | Fast port scanner | `masscan -p1-65535 target.com` |
| **rustscan** | rustscan | Modern port scanner | `rustscan -a target.com` |

### Cloud Enumeration

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **s3scanner** | s3scanner | S3 bucket scanner | `s3scanner target-bucket` |
| **gcs-bucket-brute** | gcs-bucket-brute (pip) | GCS bucket brute-forcer | `python3 gcs_bucket_brute.py` |
| **cloud_enum** | cloud_enum (pip) | Multi-cloud enumeration | `python3 cloud_enum.py -k target` |

### Automation Frameworks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **recon-ng** | recon-ng | Reconnaissance framework | `recon-ng` (interactive) |
| **thehive** | thehive (manual) | Security operations platform | Web interface |
| **maltego** | maltego | Visual investigation | GUI application |

---

## 🔁 Replay Attack Agent - Kali Tools

### Traffic Capture & Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **wireshark** | wireshark | Network protocol analyzer | `wireshark` (GUI) or `tshark -i eth0` |
| **tcpdump** | tcpdump | Packet capture | `tcpdump -i eth0 -w capture.pcap` |
| **mitmproxy** | mitmproxy | MITM proxy | `mitmproxy --mode regular` |
| **burpsuite** | burpsuite | Web proxy/interceptor | GUI application |
| **zap** | owasp-zap | Web app scanner/proxy | GUI application |

### JWT & Token Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **jwt-tool** | jwt-tool (pip) | JWT testing toolkit | `python3 jwt_tool.py TOKEN` |
| **jwtcrack** | jwtcrack (pip) | JWT cracker | `jwtcrack TOKEN` |
| **jose** | jose (manual) | JOSE library | Various JWT operations |

### Windows/Enterprise Auth Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **impacket** | impacket | Windows protocol tools | Multiple scripts below |
| **psexec.py** | impacket | PsExec implementation | `psexec.py user:pass@target` |
| **secretsdump.py** | impacket | Credential dumping | `secretsdump.py target` |
| **ntlmrelayx.py** | impacket | NTLM relay attacks | `ntlmrelayx.py -t target` |
| **responder** | responder | LLMNR/NBT-NS poisoner | `responder -I eth0 -wrf` |
| **mimikatz** | mimikatz (manual) | Windows credential tool | `mimikatz.exe` (Windows) |

### OAuth/SAML Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **samlraider** | samlraider (burp ext) | SAML testing | Burp Suite extension |
| **oauth-tester** | oauth-tester (manual) | OAuth flow testing | Python script |
| **authmatrix** | authmatrix (burp ext) | Authorization testing | Burp Suite extension |

### Hash Cracking

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **hashcat** | hashcat | Password recovery | `hashcat -m 16500 hash.txt wordlist.txt` |
| **john** | john | John the Ripper | `john --wordlist=wordlist.txt hash.txt` |
| **hcxtools** | hcxtools | Hash conversion | `hashcat -m 2500 hash.hc22000 wordlist.txt` |

### Session Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **hammar** | hammar (manual) | Session replay testing | Custom scripts |
| **repeater** | burpsuite | Request replay | Burp Suite module |
| **curl** | curl | HTTP requests | `curl -H "Cookie: session=xxx" http://target` |

### Kerberos Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **kerbrute** | kerbrute (go) | Kerberos brute-force | `kerbrute bruteusernames` |
| **rubeus** | rubeus (manual) | Kerberos abuse | Windows tool |
| **ticketer.py** | impacket | Golden ticket creation | `ticketer.py -domain-sid SID domain/user` |

---

## 🔍 Reverse Engineering Specialist - Kali Tools

### Disassemblers & Decompilers

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **ghidra** | ghidra | NSA reverse engineering | `ghidraRun` (GUI) |
| **radare2** | radare2 | Reverse engineering framework | `r2 binary` |
| **cutter** | cutter | GUI for radare2 | `cutter binary` (GUI) |
| **binaryninja** | binaryninja (manual) | Commercial disassembler | GUI application |
| **ida-free** | ida-free (manual) | IDA Free version | GUI application |
| **r2dec** | r2dec | Radare2 decompiler | `r2 -qA dec binary` |

### Debuggers

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **gdb** | gdb | GNU debugger | `gdb ./binary` |
| **pwndbg** | pwndbg (pip) | GDB enhancements | `gdb -p pwndbg ./binary` |
| **gef** | gef (manual) | GDB enhanced | GDB plugin |
| **x64dbg** | x64dbg (wine) | Windows debugger | Windows tool via Wine |
| **edb** | edb | Evan's debugger | `edb --run ./binary` |

### Dynamic Instrumentation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **frida-tools** | frida-tools (pipx) | Dynamic instrumentation | `frida -U -f app -l script.js` |
| **objection** | objection (pipx) | Mobile runtime exploration | `objection explore` |
| **lief** | lief (pip) | Binary instrumentation | Python library |
| **pin** | pin (manual) | Intel PIN | Binary instrumentation |

### Android RE

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **jadx** | jadx | APK decompiler | `jadx -d output app.apk` |
| **apktool** | apktool | APK reverse engineering | `apktool d app.apk` |
| **bytecode-viewer** | bytecode-viewer | Java/Android viewer | GUI application |
| **androguard** | androguard | Android analysis | `python3 androguard` |
| **mobsf** | mobsf (manual) | Mobile security framework | Web interface |

### iOS RE

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **ideviceinstaller** | ideviceinstaller | iOS app installer | `ideviceinstaller -l` |
| **frida-ios-dump** | frida-ios-dump (manual) | iOS app dumping | Python script |
| **class-dump** | class-dump (manual) | Objective-C header dump | `class-dump app` |

### Firmware Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **binwalk** | binwalk | Firmware analysis | `binwalk -e firmware.bin` |
| **firmwalker** | firmwalker (manual) | Firmware crawler | `./firmwalker.sh extracted/` |
| **fact** | fact (manual) | Firmware analysis tool | Web interface |
| **sasquatch** | sasquatch | SquashFS extraction | `sasquatch image.squashfs` |

### Binary Exploitation

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **pwntools** | pwntools (pip) | CTF/exploit framework | `python3 exploit.py` |
| **ropgadget** | ropgadget | ROP chain finder | `ROPgadget --binary binary` |
| **one_gadget** | one_gadget (gem) | One-gadget RCE | `one_gadget libc.so.6` |
| **angr** | angr (pip) | Binary analysis | Python library |
| **checksec** | checksec | Binary protection check | `checksec --file binary` |

### Malware Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **yara** | yara | Pattern matching | `yara rule.yar malware` |
| **yaragen** | yaragen (pip) | YARA rule generator | `yaragen -g malware` |
| **peframe** | peframe (pip) | PE static analyzer | `peframe malware.exe` |
| **pebear** | pbear (manual) | PE analyzer | GUI application |
| **strings** | binutils | String extraction | `strings malware` |
| **floss** | floss (manual) | Advanced string extraction | `floss malware` |
| **capstone** | capstone (pip) | Disassembly framework | Python library |
| **keystone** | keystone (pip) | Assembler framework | Python library |

### File Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **file** | file | File type identification | `file suspicious` |
| **exiftool** | libimage-exiftool-perl | Metadata extraction | `exiftool file` |
| **pefile** | pefile (pip) | PE parser | Python library |
| **elftools** | pyelftools (pip) | ELF parser | Python library |

### Sandbox/Analysis Environments

| Tool | Package | Purpose |
|------|---------|---------|
| **remnux** | remnux (separate VM) | Malware analysis distro |
| **flare-vm** | flare-vm (Windows) | Windows RE VM |
| **any.run** | Web service | Interactive sandbox |

---

## 📡 Sub-GHz SDR Specialist - Kali Tools

### SDR Hardware Support

| Device | Kali Support | Notes |
|--------|--------------|-------|
| **RTL-SDR** | ✅ Native (rtl-sdr) | Receive only, $25 |
| **HackRF** | ✅ Native (hackrf) | TX/RX, $300 |
| **BladeRF** | ✅ Native (bladerf) | Full-duplex, $420+ |
| **USRP** | ✅ Native (uhd) | Professional, $1000+ |
| **LimeSDR** | ✅ Native (limesuite) | Full-duplex, $280 |
| **PlutoSDR** | ✅ Native (iio) | ADALM-Pluto, $400 |
| **YARD Stick One** | ⚠️ Manual (rfcat) | Sub-GHz pentesting |
| **Flipper Zero** | ⚠️ Manual | Multi-tool, requires firmware |

### SDR Software (Kali)

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **gqrx** | gqrx | SDR receiver | `gqrx` (GUI) |
| **sdrsharp** | sdrsharp (wine) | SDR receiver | Windows tool via Wine |
| **gnuradio** | gnuradio | SDR development | `gnuradio-companion` (GUI) |
| **inspectrum** | inspectrum | Signal analysis | `inspectrum capture.cfile` |
| **urh** | urh | Universal Radio Hacker | `urh` (GUI) |
| **rtl_433** | rtl_433 | Sensor decoder | `rtl_433 -f 433920000` |
| **rtl_tcp** | rtl-sdr | RTL-SDR server | `rtl_tcp -a 0.0.0.0` |
| **hackrf_transfer** | hackrf | HackRF transfer | `hackrf_transfer -r capture.bin` |
| **hackrf_sweep** | hackrf | Frequency sweep | `hackrf_sweep` |

### RF Analysis Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **baudline** | baudline (manual) | Signal analyzer | GUI application |
| **specplot** | specplot (manual) | Spectrum plotting | Python script |
| **csdr** | csdr | SDR DSP library | Command-line DSP |
| **liquid-dsp** | liquid-dsp | DSP library | Development library |

### Protocol Decoders

| Tool | Package | Purpose | Frequency |
|------|---------|---------|-----------|
| **rtl_433** | rtl_433 | Weather, IoT sensors | 433 MHz |
| **gr-zigbee** | gnuradio + gr-zigbee | Zigbee decoding | 2.4 GHz |
| **gr-ieee802-15-4** | gnuradio module | 802.15.4 decoding | 2.4 GHz |
| **rfcat** | rfcats (pip) | RF testing framework | Sub-GHz |
| **yardstick** | yardstick (manual) | YARD Stick tools | 300-928 MHz |

### IoT Protocol Tools

| Tool | Package | Purpose | Protocol |
|------|---------|---------|----------|
| **killerbee** | killerbee (pip) | Zigbee framework | Zigbee |
| **ubertooth** | ubertooth | Bluetooth analysis | Bluetooth |
| **gr-bluetooth** | gnuradio module | Bluetooth SDR | Bluetooth |
| **lorawan** | lora-gateway (manual) | LoRaWAN analysis | LoRa |

### Signal Processing

| Tool | Package | Purpose |
|------|---------|---------|
| **audacity** | audacity | Audio/signal editing |
| **sox** | sox | Audio processing |
| **qspectrumanalyzer** | qspectrumanalyzer | Spectrum analysis |
| **satdump** | satdump (manual) | Satellite reception |

### Antenna & Hardware

| Item | Purpose | Notes |
|------|---------|-------|
| **Antennas** | 433/868/915 MHz | Improve range |
| **LNA** | Low-noise amplifier | Boost weak signals |
| **Filters** | Bandpass filters | Reduce interference |
| **Cables** | SMA/RP-SMA | Quality connections |

---

## 📶 WiFi Security Tester - Kali Tools

### WiFi Adapters (Monitor Mode + Injection)

| Adapter | Chipset | Kali Support | Price |
|---------|---------|--------------|-------|
| **Alfa AWUS036NHA** | Atheros AR9271 | ✅ Native | $40 |
| **Alfa AWUS036ACS** | Realtek RTL8812AU | ✅ Native | $50 |
| **Alfa AWUS1900** | Realtek RTL8814AU | ✅ Native | $100 |
| **Panda PAU09** | Ralink RT5572 | ✅ Native | $30 |
| **TP-Link TL-WN722N** | Atheros (v1 only) | ✅ Native | $20 |

### Core WiFi Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **aircrack-ng** | aircrack-ng | WiFi security suite | Multiple tools below |
| **airodump-ng** | aircrack-ng | Packet capture | `airodump-ng wlan0mon` |
| **aireplay-ng** | aircrack-ng | Packet injection | `aireplay-ng --deauth 10 wlan0mon` |
| **aircrack-ng** | aircrack-ng | WEP/WPA cracking | `aircrack-ng capture.cap -w wordlist.txt` |
| **airbase-ng** | aircrack-ng | Evil twin AP | `airbase-ng -e "FakeAP" wlan0mon` |
| **hostapd** | hostapd | Access point daemon | `hostapd hostapd.conf` |

### Handshake & PMKID Capture

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **hcxdumptool** | hcxdumptool | PMKID capture | `hcxdumptool -i wlan0mon -o capture.pcapng` |
| **hcxpcapngtool** | hcxdumptool | Hash conversion | `hcxpcapngtool -o hash.hc22000 capture.pcapng` |
| **wash** | reaver | WPS detection | `wash -i wlan0mon` |

### WPS Attacks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **reaver** | reaver | WPS brute-force | `reaver -i wlan0mon -b BSSID -vv` |
| **bully** | bully | WPS brute-force | `bully wlan0mon --bssid BSSID` |
| **pixiewps** | pixiewps | WPS pixie-dust | `pixiewps -e [params]` |

### Password Cracking

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **hashcat** | hashcat | GPU cracking | `hashcat -m 2500 hash.txt wordlist.txt` |
| **john** | john | CPU cracking | `john --wordlist=wordlist.txt hash.txt` |
| **crunch** | crunch | Wordlist generation | `crunch 8 12 abc123 -o wordlist.txt` |

### Evil Twin Attacks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **fluxion** | fluxion | Evil twin automation | `./fluxion.sh` |
| **wifiphisher** | wifiphisher | WiFi phishing | `wifiphisher -aBSSID` |
| **mana** | mana | KARMA attacks | `mana-toolkit` |
| **hostapd-mana** | hostapd-mana | Evil twin with KARMA | `hostapd-mana.conf` |

### Enterprise WiFi Testing

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **eaphammer** | eaphammer | Enterprise attacks | `eaphammer --interface wlan0mon` |
| **asleap** | asleap | LEAP cracking | `asleap -C challenge -R response -W wordlist` |
| **peap** | freeradius | PEAP testing | `freeradius` configuration |

### Wireless Scanning & Detection

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **kismet** | kismet | Wireless IDS | `kismet -c wlan0mon` |
| **wash** | reaver | WPS scanner | `wash -i wlan0mon` |
| **mdk4** | mdk4 | WiFi attack tool | `mdk4 wlan0mon p -b BSSID` |
| **wigle** | wigle (web) | WiFi mapping | Web service |

### Network Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **wireshark** | wireshark | Packet analysis | `wireshark -i wlan0mon` |
| **tshark** | wireshark | CLI packet analysis | `tshark -i wlan0mon` |
| **tcpdump** | tcpdump | Packet capture | `tcpdump -i wlan0mon -w capture.pcap` |

### Wordlists for WiFi

| Location | Content |
|----------|---------|
| `/usr/share/wordlists/rockyou.txt` | Famous leaked passwords |
| `/usr/share/wordlists/fasttrack.txt` | Fasttrack wordlist |
| `/usr/share/hashcat/masks/` | Hashcat mask files |
| `crunch` generated | Custom wordlists |

### WiFi Hardening Tools

| Tool | Package | Purpose |
|------|---------|---------|
| **wpa_supplicant** | wpa_supplicant | WPA client |
| **iw** | iw | Wireless config |
| **iwconfig** | wireless-tools | Wireless config (legacy) |

---

## Tool Integration Matrix

### Cross-Agent Tool Usage

| Tool | Web Pentesting | Bug Bounty | Replay Attack | Reverse Engineering | Sub-GHz SDR | WiFi Security |
|------|----------------|------------|---------------|---------------------|-------------|---------------|
| **Burp Suite** | ✅ Primary | ✅ Primary | ✅ Primary | ❌ | ❌ | ❌ |
| **Nmap** | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Wireshark** | ⚠️ | ⚠️ | ✅ Primary | ⚠️ | ⚠️ | ✅ |
| **Hashcat** | ⚠️ | ⚠️ | ✅ | ⚠️ | ❌ | ✅ Primary |
| **Nuclei** | ✅ Primary | ✅ Primary | ❌ | ❌ | ❌ | ❌ |
| **Ffuf** | ✅ Primary | ✅ Primary | ❌ | ❌ | ❌ | ❌ |
| **Ghidra** | ❌ | ❌ | ❌ | ✅ Primary | ❌ | ❌ |
| **Frida** | ❌ | ⚠️ | ❌ | ✅ Primary | ❌ | ❌ |
| **Aircrack-ng** | ❌ | ❌ | ❌ | ❌ | ⚠️ | ✅ Primary |
| **GNU Radio** | ❌ | ❌ | ❌ | ❌ | ✅ Primary | ❌ |
| **SQLmap** | ✅ Primary | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Metasploit** | ✅ | ❌ | ⚠️ | ⚠️ | ❌ | ❌ |

**Legend:** ✅ Primary | ⚠️ Secondary | ❌ Not applicable

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali (Top Tools)

| Agent | Pre-Installed Tools |
|-------|---------------------|
| **Web Pentesting** | Burp Suite, SQLmap, Nikto, Gobuster, Wapiti, Skipfish, SSLscan |
| **Bug Bounty** | Subfinder, Amass, Nuclei, Ffuf, Whatweb, theHarvester |
| **Replay Attack** | Wireshark, Impacket, Responder, Hashcat, John |
| **Reverse Engineering** | Ghidra, Radare2, GDB, Binwalk, Yara, jadx, apktool |
| **Sub-GHz SDR** | GNU Radio, GQRX, rtl-sdr, hackrf, inspectrum, urh |
| **WiFi Security** | Aircrack-ng suite, Reaver, Kismet, Hashcat, hcxdumptool |

### Manual Install Required

| Tool | Agent | Install Command |
|------|-------|-----------------|
| **Burp Suite Pro** | Web/Bug Bounty | Download from PortSwigger |
| **Postman** | Web Pentesting | `snap install postman` |
| **MobSF** | Reverse Engineering | `git clone && docker run` |
| **Flipper Zero tools** | Sub-GHz SDR | qFlipper desktop app |
| **Class-dump** | Reverse Engineering | `brew install class-dump` (macOS) |

---

## Quick Reference: Top 10 Tools Per Agent

### Web Pentesting Top 10
1. Burp Suite
2. SQLmap
3. Nuclei
4. Ffuf/Gobuster
5. XSStrike
6. Nikto
7. Whatweb
8. SSLscan
9. Arjun
10. Wappalyzer

### Bug Bounty Top 10
1. Subfinder
2. Amass
3. Nuclei
4. Ffuf
5. httpx
6. Waybackurls/GAU
7. LinkFinder
8. Aquatone
9. theHarvester
10. Dalfox

### Replay Attack Top 10
1. Burp Suite
2. jwt_tool
3. Wireshark
4. Impacket
5. Responder
6. Hashcat
7. Mitmproxy
8. Rubeus
9. SAML Raider
10. Kerbrute

### Reverse Engineering Top 10
1. Ghidra
2. Radare2/Cutter
3. GDB/Pwndbg
4. Frida
5. jadx
6. Apktool
7. Binwalk
8. Yara
9. Pwntools
10. Checksec

### Sub-GHz SDR Top 10
1. GNU Radio
2. GQRX
3. rtl_433
4. URH
5. Inspectrum
6. HackRF tools
7. rfcat
8. KillerBee
9. Audacity
10. QSpectrumAnalyzer

### WiFi Security Top 10
1. Aircrack-ng suite
2. Hashcat
3. hcxdumptool
4. Reaver
5. Kismet
6. Wireshark
7. Fluxion
8. Eaphammer
9. Bully
10. MDK4

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
