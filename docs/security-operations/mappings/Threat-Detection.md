# Threat Detection - Kali Linux Tool Mapping

**Agent:** 🎯 Threat Detection  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 45  
**Status:** Complete

---

## Overview

**Mission:** Proactive threat hunting, detection engineering, and security monitoring to identify adversaries before they cause damage.

**Primary Use Cases:**
- Threat hunting (hypothesis-driven)
- Detection rule development (Sigma, YARA, Suricata)
- SIEM management and tuning
- Threat intelligence integration
- Behavioral analysis and anomaly detection
- MITRE ATT&CK mapping

---

## 1. SIEM & Log Management

### SIEM Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **elasticsearch** | elasticsearch | Search engine | `curl localhost:9200/_cluster/health` |
| **logstash** | logstash | Log processing | `logstash -f pipeline.conf` |
| **kibana** | kibana | Visualization | Web interface (5601) |
| **wazuh** | wazuh | Security monitoring | Web interface |
| **ossim** | ossim | SIEM platform | Web interface |
| **splunk** | splunk (manual) | Enterprise SIEM | Web interface (8089) |
| **graylog** | graylog (manual) | Log management | Web interface (9000) |

### Elasticsearch Query Examples
```bash
# Failed logins in last hour
GET /logs-*/_search
{
  "query": {
    "bool": {
      "filter": [
        { "match": { "event.action": "failed_login" } },
        { "range": { "@timestamp": { "gte": "now-1h" } } }
      ]
    }
  }
}

# Brute force detection
GET /logs-*/_search
{
  "aggs": {
    "by_ip": {
      "terms": { "field": "source.ip" },
      "aggs": {
        "failures": {
          "filter": { "match": { "event.outcome": "failure" } }
        }
      }
    }
  },
  "size": 0
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

## 2. Threat Hunting

### Hunting Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **velociraptor** | velociraptor | Endpoint hunting | `velociraptor hunt "SELECT * FROM processes"` |
| **osquery** | osquery | System querying | `osqueryi "SELECT * FROM processes"` |
| **grr** | grr (manual) | Remote response | Web interface |
| **timesketch** | timesketch (pip) | Timeline analysis | Web interface |
| **jupyter** | jupyter (pip) | Notebook analysis | `jupyter notebook` |

### Osquery Hunting Queries
```sql
-- Suspicious processes
SELECT name, path, pid FROM processes 
WHERE path LIKE '%temp%' 
   OR path LIKE '%appdata%' 
   OR name LIKE '%mimikatz%'
   OR name LIKE '%bloodhound%';

-- Persistence mechanisms
SELECT * FROM startup_items WHERE path NOT LIKE '%Program Files%';

-- Scheduled tasks
SELECT name, path, args FROM scheduled_tasks 
WHERE path NOT LIKE '%Windows%' AND path NOT LIKE '%Program Files%';

-- Browser extensions
SELECT name, identifier, path FROM chrome_extensions WHERE installed_time > (strftime('%s', 'now') - 86400);

-- Listening ports with process info
SELECT p.name, p.path, l.port, l.pid 
FROM listening_ports l 
JOIN processes p ON l.pid = p.pid 
WHERE l.address NOT IN ('0.0.0.0', '127.0.0.1');

-- Recently modified system files
SELECT path, mtime FROM file 
WHERE path LIKE '/etc/%' 
  AND mtime > (strftime('%s', 'now') - 86400);
```

### Velociraptor Hunting Queries
```yaml
# Hunt for Mimikatz
name: Hunt.Mimikatz
sources:
  - SELECT Name, Pid, Path, CmdLine FROM processes() 
    WHERE CmdLine =~ "(?i)mimikatz|sekurlsa|kerberos"

# Hunt for living-off-the-land binaries
name: Hunt.LOLBins
sources:
  - SELECT Name, Path, CmdLine FROM processes()
    WHERE Name IN ("certutil.exe", "bitsadmin.exe", "mshta.exe", "rundll32.exe", "regsvr32.exe")
      AND CmdLine =~ "(?i)download|decode|execute|bypass"
```

---

## 3. Detection Rule Development

### Sigma Rules

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **sigma** | sigma (pip) | Detection rules | `sigma convert -t splunk rule.yml` |
| **sigmahq** | sigmahq (web) | Rule repository | https://github.com/SigmaHQ/sigma |
| **sigma-cli** | sigma (pip) | CLI tool | `sigma validate rule.yml` |

### Sigma Rule Examples
```yaml
title: Suspicious PowerShell Encoded Command
id: 12345678-1234-1234-1234-123456789012
status: experimental
description: Detects PowerShell with encoded commands
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        Image|endswith: '\powershell.exe'
        CommandLine|contains:
            - '-enc'
            - '-encodedcommand'
            - '-e '
    condition: selection
level: high
tags:
    - mitre.attack.T1059.001
    - mitre.attack.T1140
```

### Sigma Conversion Commands
```bash
# Validate rule
sigma validate windows_powershell_encoded.yml

# Convert to Splunk
sigma convert -t splunk windows_powershell_encoded.yml

# Convert to Elastic
sigma convert -t elasticsearch windows_powershell_encoded.yml

# Convert to Defender
sigma convert -t defender windows_powershell_encoded.yml

# Convert to multiple formats
sigma convert -t splunk,elasticsearch,defender,qradar rule.yml

# Test with sample logs
sigma scan -t splunk rule.yml sample_logs.txt
```

### YARA Rules

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **yara** | yara | Pattern matching | `yara -r rules/ suspicious/` |
| **yaragen** | yaragen (pip) | YARA generator | `yaragen -g malware` |
| **yara-python** | yara (pip) | Python integration | `import yara` |

### YARA Rule Examples
```yara
rule Suspicious_PowerShell_Download {
    meta:
        description = "Detects PowerShell download patterns"
        author = "Threat Detection Team"
        reference = "MITRE ATT&CK T1059.001"
    strings:
        $ps1 = "powershell" nocase
        $ps2 = "Invoke-WebRequest" nocase
        $ps3 = "DownloadString" nocase
        $ps4 = "DownloadFile" nocase
        $url = "http://" nocase
    condition:
        $ps1 and ($ps2 or $ps3 or $ps4) and $url
}

rule CobaltStrike_Beacon {
    meta:
        description = "Detects CobaltStrike beacon patterns"
        author = "Threat Detection Team"
    strings:
        $header1 = "X-Operations" nocase
        $header2 = "X-Status" nocase
        $beacon = { 00 00 BE EF CA FE }
    condition:
        any of them
}
```

### Suricata Rules

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **suricata** | suricata | Network IDS | `suricata -c suricata.yaml -i eth0` |
| **suricata-update** | suricata | Rule management | `suricata-update` |

### Suricata Rule Examples
```
# Detect PowerShell over HTTP
alert http any any -> any any (
    msg:"ET POLICY PowerShell User-Agent";
    flow:established,to_server;
    content:"PowerShell"; http_user_agent;
    classtype:policy-violation;
    sid:2019276;
    rev:1;
)

# Detect CobaltStrike beacon
alert http any any -> any any (
    msg:"COBALTSTRIKE Beacon Activity";
    flow:established;
    content:"X-Operations"; http_header;
    classtype:trojan-activity;
    sid:1000001;
    rev:1;
)
```

---

## 4. Threat Intelligence

### TIP Platforms

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **misp** | misp (manual) | Threat intel platform | Web interface |
| **opencti** | opencti (manual) | CTI platform | Web interface |
| **anubis** | anubis (manual) | Threat intel | Web interface |
| **threatconnect** | threatconnect (manual) | TI platform | Web interface |
| **taxii** | taxii (pip) | TI sharing protocol | `taxii-discovery --help` |

### IOC Integration
```python
# Pull IOCs from MISP
import pymisp

misp = PyMISP('https://misp.local', 'API_KEY')
events = misp.search(controller='events', timestamp='1d')

for event in events:
    for attr in event['Attribute']:
        ioc = attr['value']
        ioc_type = attr['type']
        
        # Create detection rule
        if ioc_type == 'md5':
            create_yara_hash(ioc)
        elif ioc_type == 'domain':
            create_suricata_domain(ioc)
        elif ioc_type == 'ip':
            create_suricata_ip(ioc)
```

### Threat Intel Enrichment
```python
# VirusTotal enrichment
import vt

client = vt.Client('API_KEY')
file = client.get_object('/files/{hash}')

print(f"Detection ratio: {file.last_analysis_stats['malicious']}/60")
print(f"First seen: {file.first_submission_date}")
print(f"Tags: {file.tags}")

# AbuseIPDB enrichment
import requests

response = requests.get(
    f'https://api.abuseipdb.com/api/v2/check',
    params={'ipAddress': '1.2.3.4'},
    headers={'Key': 'API_KEY'}
)
data = response.json()
print(f"Abuse score: {data['data']['abuseConfidenceScore']}%")
```

---

## 5. Behavioral Analysis

### UEBA Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **elastic-siem** | elastic | Behavioral detection | Kibana ML jobs |
| **sysmon** | sysmon (Windows) | System monitoring | `Sysmon64.exe -i config.xml` |
| **wazuh** | wazuh | Behavior monitoring | Web interface |
| **falco** | falco | Runtime security | `falco --config falco_rules.yaml` |

### Sysmon Configuration
```xml
<Sysmon schemaversion="4.81">
  <EventFiltering>
    <!-- Process Creation -->
    <RuleGroup groupRelation="or">
      <ProcessCreate onmatch="include">
        <CommandLine condition="contains">powershell -enc</CommandLine>
        <CommandLine condition="contains">mimikatz</CommandLine>
        <Image condition="end with">\temp\*.exe</Image>
      </ProcessCreate>
    </RuleGroup>
    
    <!-- Network Connections -->
    <RuleGroup groupRelation="or">
      <NetworkConnect onmatch="include">
        <DestinationPort condition="is">4444</DestinationPort>
        <DestinationPort condition="is">5555</DestinationPort>
        <Image condition="end with">\powershell.exe</Image>
      </NetworkConnect>
    </RuleGroup>
  </EventFiltering>
</Sysmon>
```

### Falco Rules
```yaml
- rule: Suspicious PowerShell Download
  desc: Detect PowerShell downloading content
  condition: (proc.name = powershell) and (proc.args contains "Download")
  output: "Suspicious PowerShell download (user=%user.name command=%proc.cmdline)"
  priority: WARNING
  tags: [powershell, download]

- rule: Sensitive File Access
  desc: Access to sensitive files
  condition: (evt.type = open) and (fd.name contains "/etc/shadow")
  output: "Sensitive file access (user=%user.name file=%fd.name)"
  priority: ERROR
  tags: [filesystem, sensitive]
```

---

## 6. Anomaly Detection

### Statistical Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **elastalert** | elastalert | Alerting for ES | `elastalert --rule rule_name.yaml` |
| **opensearch** | opensearch | Search/analytics | Web interface |
| **prometheus** | prometheus | Metrics + alerting | `prometheus --config.file=prometheus.yml` |
| **grafana** | grafana | Visualization | Web interface (3000) |

### ElastAlert Rule Examples
```yaml
name: Failed Login Spike
type: spike
index: logs-*
filter:
  - term:
      event.action: failed_login
spike_height: 5
spike_type: up
timeframe:
  minutes: 5
alert:
  - email
email:
  - security@company.com
```

---

## 7. MITRE ATT&CK Mapping

### ATT&CK Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **attack-navigator** | attack-navigator (web) | Coverage visualization | Web-based |
| **mitre-attack** | mitre-attack (pip) | API access | `pip install mitre-attack-framework` |
| **car** | car (web) | Analytics repository | https://car.mitre.org |
| **sigma** | sigma (pip) | Detection rules | `sigma convert -t splunk rule.yml` |

### Detection Coverage Mapping
```
1. Export existing detections
   - SIEM rules
   - YARA rules
   - Suricata rules

2. Map to MITRE ATT&CK
   - Use ATT&CK Navigator
   - Color by coverage status

3. Identify gaps
   - Techniques without detections
   - Prioritize by risk

4. Create new detections
   - Use Sigma format
   - Test with Atomic Red Team

5. Update coverage map
   - Mark techniques as detected
   - Export layer for reporting
```

---

## Top 10 Threat Detection Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Sigma** | Detection | Detection rule standard |
| 2 | **Elastic Stack** | SIEM | Log analysis + ML |
| 3 | **Wazuh** | SIEM/HIDS | Open-source monitoring |
| 4 | **Velociraptor** | Hunting | Endpoint visibility |
| 5 | **Osquery** | Hunting | System querying |
| 6 | **YARA** | Detection | Malware pattern matching |
| 7 | **Suricata** | Network | Network threat detection |
| 8 | **MISP** | Threat Intel | IOC sharing |
| 9 | **ATT&CK Navigator** | Mapping | Coverage visualization |
| 10 | **Timesketch** | Timeline | Timeline analysis |

---

## Quick Reference Commands

### Sigma Rule Development
```bash
# Create new rule
cat > new_detection.yml << EOF
title: New Detection Rule
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        Image|endswith: '\powershell.exe'
    condition: selection
level: medium
EOF

# Validate
sigma validate new_detection.yml

# Convert to target format
sigma convert -t splunk new_detection.yml
sigma convert -t elasticsearch new_detection.yml

# Test with logs
sigma scan -t splunk new_detection.yml sample_logs.txt
```

### Threat Hunting
```bash
# Osquery - suspicious processes
osqueryi "SELECT name, path FROM processes WHERE path LIKE '%temp%'"

# Velociraptor hunt
velociraptor --config config.yaml hunt \
  "SELECT * FROM processes WHERE name LIKE '%mimikatz%'"

# Elasticsearch - failed logins
curl -X GET "localhost:9200/logs-*/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": { "event.action": "failed_login" }
  }
}'
```

### IOC Integration
```bash
# Extract IOCs from report
python3 iocextract.py < threat_report.txt > iocs.txt

# Validate with VirusTotal
vt file < hash.txt

# Add to MISP
# Web interface or API
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **SIEM** | Elasticsearch, Logstash, Kibana, Wazuh |
| **Hunting** | Osquery, Velociraptor |
| **Detection** | Yara, Suricata, Sigma |
| **Network** | Wireshark, Zeek |
| **Timeline** | Timesketch, Plaso |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Splunk** | Download from Splunk | Free up to 500MB/day |
| **MISP** | apt + web setup | Threat intel platform |
| **OpenCTI** | Docker compose | Modern CTI platform |
| **ATT&CK Navigator** | Web/GitHub | Coverage mapping |
| **Grafana** | apt or Docker | Visualization |
| **Prometheus** | apt or Docker | Metrics + alerting |
| **ElastAlert** | pip | Alerting for ES |

---

## Integration with Other Agents

| Agent | Collaboration Point |
|-------|---------------------|
| **Blue Team** | Share detection rules, IOCs |
| **Purple Team** | Validate detection coverage |
| **Red Team** | Learn attacker TTPs |
| **Incident Response** | Receive IOCs from incidents |
| **Threat Intelligence** | Consume/produce threat intel |
| **Security Engineer** | Implement detection infrastructure |

---

## Detection Engineering Workflow

```
1. Identify requirement
   - New threat intel
   - Incident learnings
   - Gap analysis

2. Research TTP
   - MITRE ATT&CK
   - CAR analytics
   - Public research

3. Develop detection
   - Write Sigma rule
   - Test with sample data

4. Convert & deploy
   - Convert to SIEM format
   - Deploy to production

5. Validate
   - Run Atomic Red Team test
   - Verify alert generation

6. Tune
   - Monitor false positives
   - Adjust rule as needed

7. Document
   - Update coverage map
   - Add to detection catalog
```

---

## Detection Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Detection Coverage** | >80% MITRE ATT&CK | ATT&CK Navigator |
| **True Positive Rate** | >90% | Alert validation |
| **False Positive Rate** | <10% | Alert analysis |
| **Time to Detect** | <5 minutes | Test execution to alert |
| **Rule Deployment Time** | <24 hours | Creation to production |
| **Detection Quality Score** | >8/10 | Rule review scoring |

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly (align with Kali releases)  
**Owner:** Security Team
