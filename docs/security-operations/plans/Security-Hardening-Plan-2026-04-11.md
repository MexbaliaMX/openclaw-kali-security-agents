# 🛡️ Plan de Hardening de Seguridad - Cluster OpenClaw

**Fecha:** April 11, 2026  
**Analista:** KaliKlaw 🥷  
**Alcance:** 3 nodos OpenClaw (111, 188, 234)  
**Score Actual:** 7.3/10 🟡  
**Score Objetivo:** 9/10 🟢

---

## 📊 Estado Actual

### Nodo 111 (KaliKlaw - Kali Linux)
| Categoría | Estado | Score |
|-----------|--------|-------|
| SSH Configuration | 🟡 Moderado | 7/10 |
| Firewall (UFW) | 🔴 No configurado | 3/10 |
| DNS Security | 🟡 ISP DNS | 6/10 |
| Service Isolation | 🟢 Localhost only | 9/10 |
| **Total** | | **6.5/10** |

### Nodo 188 (langosta - Ubuntu Server)
| Categoría | Estado | Score |
|-----------|--------|-------|
| SSH Configuration | 🟡 Password auth | 6/10 |
| Firewall (UFW) | 🔴 No configurado | 3/10 |
| Fail2ban | 🔴 No instalado | 4/10 |
| Log Monitoring | 🟡 Básico | 6/10 |
| **Total** | | **4.75/10** |

### Nodo 234 (tenazas - Ubuntu Server)
| Categoría | Estado | Score |
|-----------|--------|-------|
| SSH Configuration | 🟡 Password auth | 6/10 |
| Firewall (UFW) | 🔴 No configurado | 3/10 |
| Fail2ban | 🔴 No instalado | 4/10 |
| Log Monitoring | 🟡 Básico | 6/10 |
| **Total** | | **4.75/10** |

---

## 🎯 Objetivos de Seguridad

### Corto Plazo (1-2 días)
- [ ] Score mínimo: 8/10 en todos los nodos
- [ ] SSH hardening completado
- [ ] UFW configurado con reglas básicas
- [ ] DNS seguro implementado

### Mediano Plazo (1 semana)
- [ ] Score mínimo: 8.5/10
- [ ] Fail2ban operativo
- [ ] Monitoreo de logs automatizado
- [ ] Backup de configuraciones

### Largo Plazo (1 mes)
- [ ] Score objetivo: 9/10
- [ ] Auditoría de seguridad trimestral
- [ ] Actualizaciones automáticas
- [ ] Documentación completa

---

## 📋 Plan de Acción Detallado

### FASE 1: Hardening SSH (Día 1)
**Tiempo estimado:** 30-45 minutos  
**Prioridad:** 🔴 CRÍTICA  
**Nodos:** 188, 234 (Ubuntu)

#### Paso 1.1: Generar llaves SSH (si no existen)
```bash
# En KaliKlaw (111)
ssh-keygen -t ed25519 -C "KaliKlaw Admin Key" -f ~/.ssh/id_ed25519
# Presionar Enter (sin passphrase para automatización)
```

#### Paso 1.2: Copiar llaves a nodos Ubuntu
```bash
# Copiar llave pública a ambos nodos
ssh-copy-id -i ~/.ssh/id_ed25519.pub 192.168.122.188
ssh-copy-id -i ~/.ssh/id_ed25519.pub 192.168.122.234

# Verificar conexión sin password
ssh -i ~/.ssh/id_ed25519 192.168.122.188 "hostname"
ssh -i ~/.ssh/id_ed25519 192.168.122.234 "hostname"
```

#### Paso 1.3: Hardening SSH en nodos Ubuntu
```bash
# En CADA nodo Ubuntu (188, 234)
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

sudo nano /etc/ssh/sshd_config
```

**Cambios requeridos:**
```bash
# Autenticación
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
AuthenticationMethods publickey

# Seguridad
PermitRootLogin no
MaxAuthTries 3
MaxSessions 5
LoginGraceTime 60
ClientAliveInterval 300
ClientAliveCountMax 2

# Solo protocolos modernos
Protocol 2
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
MACs umac-128-etm@openssh.com,umac-64-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com
HostKeyAlgorithms ssh-ed25519,rsa-sha2-512,rsa-sha2-256

# Logging
LogLevel VERBOSE
SyslogFacility AUTH
```

**Reiniciar SSH:**
```bash
sudo systemctl restart ssh
sudo systemctl status ssh
```

#### Paso 1.4: Agregar host keys a known_hosts
```bash
# En KaliKlaw (111)
ssh-keyscan 192.168.122.188 >> ~/.ssh/known_hosts 2>/dev/null
ssh-keyscan 192.168.122.234 >> ~/.ssh/known_hosts 2>/dev/null

# Verificar
ssh-keygen -F 192.168.122.188
ssh-keygen -F 192.168.122.234
```

#### Paso 1.5: Verificar configuración
```bash
# En cada nodo Ubuntu
sudo sshd -t  # Verificar sintaxis (sin output = OK)
sudo ss -tlnp | grep :22  # Verificar puerto 22 escuchando
```

**Criterios de éxito:**
- [ ] Conexión SSH sin password funciona
- [ ] Password authentication rechazado
- [ ] Host keys en known_hosts
- [ ] SSH service running sin errores

---

### FASE 2: Firewall UFW (Día 1-2)
**Tiempo estimado:** 20-30 minutos  
**Prioridad:** 🔴 CRÍTICA  
**Nodos:** 111, 188, 234

#### Paso 2.1: Configurar UFW en KaliKlaw (`<node-111-ip>`)
```bash
# Reset y configuración base
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH desde red local
sudo ufw allow from <trusted-network>/24 to any port 22 proto tcp comment 'SSH from lab network'

# OpenClaw Gateway (localhost)
sudo ufw allow from 127.0.0.1 to any port 18789,18791,42725 proto tcp comment 'OpenClaw Gateway'

# mDNS para descubrimiento
sudo ufw allow 5353/udp comment 'mDNS service discovery'

# ICMP (ping) - opcional
sudo ufw allow in proto icmp comment 'Allow ping'

# Habilitar UFW
sudo ufw --force enable
sudo ufw status verbose
```

#### Paso 2.2: Configurar UFW en nodos Ubuntu (`<node-188-ip>`, `<node-234-ip>`)
```bash
# En CADA nodo Ubuntu
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH desde red local
sudo ufw allow from <trusted-network>/24 to any port 22 proto tcp comment 'SSH from lab network'

# SSH desde nodos específicos (inter-node)
sudo ufw allow from <node-111-ip> to any port 22 proto tcp comment 'SSH from KaliKlaw'
sudo ufw allow from <node-188-ip> to any port 22 proto tcp comment 'SSH from Node1'  # Solo en 234
sudo ufw allow from <node-234-ip> to any port 22 proto tcp comment 'SSH from Node2'  # Solo en 188

# ICMP (ping)
sudo ufw allow in proto icmp comment 'Allow ping'

# Habilitar UFW
sudo ufw --force enable
sudo ufw status verbose
```

#### Paso 2.3: Verificar conectividad
```bash
# Desde KaliKlaw (`<node-111-ip>`), probar conexión a nodos
ping -c 3 <node-188-ip>
ping -c 3 <node-234-ip>

# Probar SSH
ssh <node-188-ip> "hostname"
ssh <node-234-ip> "hostname"

# Verificar reglas UFW
sudo ufw status numbered
```

**Criterios de éxito:**
- [ ] UFW activo en los 3 nodos
- [ ] SSH funciona desde red local
- [ ] Ping entre nodos funciona
- [ ] Reglas documentadas

---

### FASE 3: DNS Security (Día 2)
**Tiempo estimado:** 10-15 minutos  
**Prioridad:** 🟡 MEDIA  
**Nodos:** 111, 188, 234

#### Paso 3.1: Configurar Quad9 DNS en KaliKlaw (111)
```bash
# Temporal (hasta reboot)
sudo cp /etc/resolv.conf /etc/resolv.conf.backup
echo "nameserver 9.9.9.9" | sudo tee /etc/resolv.conf
echo "nameserver 149.112.112.112" | sudo tee -a /etc/resolv.conf

# Permanente (NetworkManager)
nmcli con show | grep -E "NAME|connection"
nmcli con mod "<connection-name>" ipv4.dns "9.9.9.9 149.112.112.112"
nmcli con up "<connection-name>"

# Verificar
dig @9.9.9.9 google.com +short
```

#### Paso 3.2: Configurar Quad9 DNS en nodos Ubuntu
```bash
# En CADA nodo Ubuntu (188, 234)
sudo cp /etc/resolv.conf /etc/resolv.conf.backup

# Método 1: Temporal
echo "nameserver 9.9.9.9" | sudo tee /etc/resolv.conf
echo "nameserver 149.112.112.112" | sudo tee -a /etc/resolv.conf

# Método 2: Permanente (netplan)
sudo nano /etc/netplan/01-netcfg.yaml
# Agregar bajo network:
#   nameservers:
#     addresses: [9.9.9.9, 149.112.112.112]

sudo netplan apply

# Verificar
dig @9.9.9.9 google.com +short
```

#### Paso 3.3: Verificar DNS security
```bash
# Test DNS leak
curl https://ifconfig.me
dig +short myip.opendns.com @resolver1.opendns.com

# Test malware blocking (Quad9)
dig @9.9.9.9 malware.testing.google.domains +short

# Test response time
time dig @9.9.9.9 google.com
```

**Criterios de éxito:**
- [ ] Quad9 DNS configurado en los 3 nodos
- [ ] DNS leak test pasa
- [ ] Malware blocking verificado
- [ ] Response time <100ms

---

### FASE 4: Fail2ban (Día 2-3)
**Tiempo estimado:** 20-30 minutos  
**Prioridad:** 🟡 MEDIA  
**Nodos:** 188, 234 (Ubuntu)

#### Paso 4.1: Instalar Fail2ban
```bash
# En CADA nodo Ubuntu
sudo apt update
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl status fail2ban
```

#### Paso 4.2: Configurar Fail2ban para SSH
```bash
# En CADA nodo Ubuntu
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.local
sudo nano /etc/fail2ban/jail.local
```

**Configuración recomendada:**
```ini
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
backend = auto

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 2h
```

**Reiniciar Fail2ban:**
```bash
sudo systemctl restart fail2ban
sudo systemctl status fail2ban
```

#### Paso 4.3: Verificar Fail2ban
```bash
# Verificar jails activos
sudo fail2ban-client status

# Verificar jail SSH
sudo fail2ban-client status sshd

# Verificar logs
sudo tail -f /var/log/fail2ban.log
```

**Criterios de éxito:**
- [ ] Fail2ban instalado y activo
- [ ] Jail SSH configurado
- [ ] Baneos registrados en logs

---

### FASE 5: Monitoreo y Logging (Día 3)
**Tiempo estimado:** 30-45 minutos  
**Prioridad:** 🟢 BAJA  
**Nodos:** 111, 188, 234

#### Paso 5.1: Configurar log rotation
```bash
# En CADA nodo
sudo nano /etc/logrotate.d/security
```

**Configuración:**
```
/var/log/auth.log
/var/log/syslog
/var/log/fail2ban.log
{
    rotate 7
    weekly
    compress
    delaycompress
    missingok
    notifempty
    create 0640 root adm
}
```

#### Paso 5.2: Script de monitoreo básico
```bash
# En KaliKlaw (111)
mkdir -p ~/scripts
nano ~/scripts/security-check.sh
```

**Script:**
```bash
#!/bin/bash
echo "=== SECURITY CHECK - $(date) ==="
echo ""
echo "Failed logins (24h):"
grep "Failed password" /var/log/auth.log | wc -l
echo ""
echo "UFW status:"
sudo ufw status | head -5
echo ""
echo "Active SSH sessions:"
who
echo ""
echo "Fail2ban status:"
sudo fail2ban-client status 2>/dev/null | grep "Jail list" || echo "N/A"
```

**Hacer ejecutable:**
```bash
chmod +x ~/scripts/security-check.sh
```

#### Paso 5.3: Agregar al crontab (opcional)
```bash
# Ejecutar diario a las 8 AM
crontab -e
# Agregar:
0 8 * * * ~/scripts/security-check.sh >> ~/logs/security-daily.log 2>&1
```

**Criterios de éxito:**
- [ ] Log rotation configurado
- [ ] Script de monitoreo funcional
- [ ] Logs retenidos por 7 días

---

## 📅 Cronograma de Implementación

| Fase | Tarea | Día | Tiempo | Prioridad |
|------|-------|-----|--------|-----------|
| 1 | SSH Hardening | Día 1 | 45 min | 🔴 CRÍTICA |
| 2 | UFW Firewall | Día 1-2 | 30 min | 🔴 CRÍTICA |
| 3 | DNS Security | Día 2 | 15 min | 🟡 MEDIA |
| 4 | Fail2ban | Día 2-3 | 30 min | 🟡 MEDIA |
| 5 | Monitoreo | Día 3 | 45 min | 🟢 BAJA |

**Tiempo total estimado:** 2.5 - 3 horas

---

## ✅ Criterios de Aceptación

### Score Objetivo por Nodo:
| Nodo | Score Actual | Score Objetivo | Mejora |
|------|--------------|----------------|--------|
| 111 (KaliKlaw) | 6.5/10 | 9/10 | +2.5 |
| 188 (langosta) | 4.75/10 | 9/10 | +4.25 |
| 234 (tenazas) | 4.75/10 | 9/10 | +4.25 |

### Métricas de Éxito:
- [ ] 0 vulnerabilidades críticas
- [ ] SSH solo con llaves (sin password)
- [ ] Firewall activo con reglas documentadas
- [ ] DNS seguro (Quad9)
- [ ] Fail2ban operativo
- [ ] Monitoreo de logs implementado
- [ ] Documentación actualizada

---

## 📁 Archivos Relacionados

- `docs/security-operations/recon/Cluster-Inventory-Vulnerability-Analysis-2026-04-11.md` — Análisis base
- `docs/security-operations/recon/Network-Recon-2026-04-11.md` — Reconocimiento de red
- `memory/2026-04-11.md` — Tareas pendientes

---

## 🔗 Tareas Pendientes Asociadas

Ver `memory/2026-04-11.md`:
- 🟡 **0. DNS Security Fix** — 10-15 min (Fase 3)
- 🟡 **0b. UFW Firewall Configuration** — 15-20 min (Fase 2)
- 🔴 **SSH Hardening** — 30-45 min (Fase 1) — NUEVA
- 🟡 **Fail2ban Setup** — 20-30 min (Fase 4) — NUEVA

---

**Estado del Plan:** 📋 PENDIENTE DE EJECUCIÓN  
**Próxima Revisión:** Después de Fase 1 completada  
**Responsable:** KaliKlaw 🥷

---

*Plan generado por KaliKlaw — OpenClaw Security Agent*
