# 🎯 Plan de Auditoría: www.mexbalia.com

**Estado:** 🟡 Pendiente de confirmación de autorización  
**Fecha de Creación:** 2026-04-10  
**Solicitante:** Wulfrano Moreno (@wulmor)

---

## ⚠️ Ética y Autorización (REQUERIDO)

### Confirmación Necesaria

Antes de proceder, **debes confirmar**:

- [ ] **www.mexbalia.com es tu propiedad** (eres owner/admin)
- [ ] **O tienes autorización explícita por escrito** del propietario
- [ ] **Comprendes que esto es testing en producción** (no staging)

### Reglas de Engagement

| Regla | Estado |
|-------|--------|
| **Solo testing no-destructivo** | ✅ Obligatorio |
| **No explotación de vulnerabilidades** | ✅ Obligatorio |
| **No descarga/exfiltración de datos** | ✅ Obligatorio |
| **Testing en ventana de bajo tráfico** | ✅ Recomendado |
| **Backup reciente del sitio** | ✅ Recomendado |
| **Notificar al equipo de ops** | ✅ Recomendado |

---

## 🎯 Objetivos del Engagement

### Fase 1: Reconocimiento Pasivo (Sin impacto)

**Agentes:** 🔭 Trend Researcher, 🔒 Security Engineer

| Tarea | Herramienta | Impacto |
|-------|-------------|---------|
| Análisis de tecnología | WhatWeb / Wappalyzer | ✅ Sin impacto |
| Búsqueda de subdominios | Subfinder / assetfinder | ✅ Sin impacto |
| Revisión de headers HTTP | curl / browser | ✅ Sin impacto |
| Análisis de DNS | dig / nslookup | ✅ Sin impacto |
| OSINT del dominio | theHarvester | ✅ Sin impacto |

**Duración estimada:** 30 minutos

---

### Fase 2: Escaneo Activo (Bajo impacto)

**Agentes:** 🔒 Security Engineer, 📸 Evidence Collector

| Tarea | Herramienta | Impacto | Precaución |
|-------|-------------|---------|------------|
| Port scanning | nmap (rate-limited) | 🟡 Bajo | Usar `-T3` (timing conservador) |
| Web vulnerability scan | nikto (rate-limited) | 🟡 Bajo | Evitar DOS modes |
| Directory enumeration | gobuster (slow) | 🟡 Bajo | Delay entre requests |
| SSL/TLS assessment | sslscan | ✅ Sin impacto | Solo handshake |
| CMS detection | whatweb | ✅ Sin impacto | Passive only |

**Duración estimada:** 45 minutos

**Comandos seguros:**
```bash
# Nmap conservador (sin impacto en producción)
nmap -sV -sC -T3 --max-rate 100 -oA scans/mexbalia-nmap www.mexbalia.com

# Nikto con rate limiting
nikto -h https://www.mexbalia.com -rate 1 -timeout 10 -o scans/mexbalia-nikto.txt

# Gobuster lento (10 req/seg)
gobuster dir -u https://www.mexbalia.com -w /usr/share/wordlists/dirb/common.txt -t 10 -o scans/mexbalia-gobuster.txt
```

---

### Fase 3: Análisis de Vulnerabilidades (Sin explotación)

**Agentes:** 👁️ Code Reviewer, 📸 Evidence Collector

| Tarea | Enfoque | Impacto |
|-------|---------|---------|
| Identificar vulnerabilidades | Solo detección, NO explotación | ✅ Sin impacto |
| Documentar evidencia | Screenshots, responses | ✅ Sin impacto |
| Mapear a OWASP Top 10 | Clasificación | ✅ Sin impacto |
| Evaluar severidad | CVSS scoring | ✅ Sin impacto |

**Duración estimada:** 30 minutos

---

### Fase 4: Reporte y Recomendaciones

**Agentes:** 📚 Technical Writer, 📋 Compliance Auditor

| Tarea | Deliverable |
|-------|-------------|
| Executive summary | 1 página para leadership |
| Technical findings | Reporte detallado con evidencia |
| Remediation plan | Prioritized fixes con effort estimates |
| Compliance mapping | OWASP, SOC 2, PCI-DSS (si aplica) |

**Duración estimada:** 30 minutos

---

## 📊 Agentes a Utilizar

| Fase | Agente | Tarea | Duración |
|------|--------|-------|----------|
| **1** | 🔭 Trend Researcher | Research threat landscape para industry | 15 min |
| **1** | 🔒 Security Engineer | Diseñar scanning methodology | 15 min |
| **2** | 🔒 Security Engineer | Guiar escaneo activo | 45 min |
| **2** | 📸 Evidence Collector | Documentar hallazgos con evidencia | 30 min |
| **3** | 👁️ Code Reviewer | Revisar código (si disponible) | 30 min |
| **3** | 🧐 Reality Checker | Validar hallazgos, deployment readiness | 20 min |
| **4** | 📋 Compliance Auditor | Mapear a frameworks | 20 min |
| **4** | 📚 Technical Writer | Escribir reporte final | 30 min |
| **4** | 📊 Senior Project Manager | Executive summary | 15 min |

**Total estimado:** 3-4 horas (con pausas entre fases)

---

## 🛡️ Precauciones para Producción

### DOs (Hacer)

- [ ] Realizar testing en horario de bajo tráfico (ej: 2-5 AM)
- [ ] Tener backup reciente del sitio
- [ ] Monitorear métricas del servidor durante testing
- [ ] Usar rate limiting en todas las herramientas
- [ ] Documentar TODO con evidencia
- [ ] Detener testing si hay impacto en usuarios

### DON'Ts (No Hacer)

- [ ] ❌ NO usar herramientas de explotación (sqlmap --batch, etc.)
- [ ] ❌ NO realizar ataques de fuerza bruta intensivos
- [ ] ❌ NO probar vulnerabilidades que puedan causar downtime
- [ ] ❌ NO descargar bases de datos o información sensible
- [ ] ❌ NO compartir hallazgos públicamente sin autorización

---

## 📁 Estructura de Archivos

```
/home/kali/.openclaw/workspace/
├── mexbalia/
│   ├── authorization.md          # Confirmación de autorización (REQUIRED)
│   ├── scans/
│   │   ├── mexbalia-nmap.nmap
│   │   ├── mexbalia-nikto.txt
│   │   └── mexbalia-gobuster.txt
│   ├── evidence/
│   │   └── screenshots/
│   └── reports/
│       ├── 01-recon-report.md
│       ├── 02-scan-report.md
│       ├── 03-vulnerability-assessment.md
│       ├── 04-qa-evidence-report.md
│       ├── 05-integration-report.md
│       ├── 06-compliance-gap-assessment.md
│       ├── 07-final-audit-report.md
│       └── 08-executive-summary.md
└── agents/
    └── [12 agent files]
```

---

## 🚀 Comandos de Inicio (Fase 1)

```bash
# Crear estructura de directorios
mkdir -p /home/kali/.openclaw/workspace/mexbalia/{scans,evidence/screenshots,reports}

# Verificar conectividad (sin impacto)
curl -I https://www.mexbalia.com

# Analizar tecnología (sin impacto)
whatweb https://www.mexbalia.com -v

# Análisis DNS (sin impacto)
dig www.mexbalia.com ANY

# Guardar headers HTTP
curl -I https://www.mexbalia.com > scans/mexbalia-headers.txt
```

---

## 📋 Checklist de Autorización

### Antes de Iniciar

- [ ] **Confirmar propiedad/autorización** del sitio
- [ ] **Documentar autorización** en `mexbalia/authorization.md`
- [ ] **Verificar backup reciente** del sitio
- [ ] **Notificar al equipo** (si aplica)
- [ ] **Seleccionar ventana de testing** (bajo tráfico)
- [ ] **Preparar monitoreo** (CPU, RAM, response time del servidor)

### Durante Testing

- [ ] **Monitorear impacto** en métricas del servidor
- [ ] **Pausar si hay anomalías** (latencia alta, errores 5xx)
- [ ] **Documentar todo** con timestamps
- [ ] **Mantener rate limiting** en todas las herramientas

### Después de Testing

- [ ] **Generar reporte completo** con todos los agentes
- [ ] **Priorizar remediation** con Security Engineer
- [ ] **Crear timeline** de fixes con Project Manager
- [ ] **Schedule re-test** después de remediation

---

## 🎯 Criterios de Éxito

| Criterio | Target |
|----------|--------|
| **Zero impacto en usuarios** | ✅ Sin downtime reportado |
| **Zero datos exfiltrados** | ✅ Solo metadata pública |
| **100% documentado** | ✅ Evidencia de todos los hallazgos |
| **Reporte accionable** | ✅ Remediation plan claro |
| **Compliance mapping** | ✅ OWASP Top 10 + frameworks relevantes |

---

## ⚠️ Disclaimer Legal

**IMPORTANTE:** Este plan asume que tienes autorización legal para realizar testing de seguridad en www.mexbalia.com. 

- Testing sin autorización es **ilegal** en la mayoría de jurisdicciones
- KaliKlaw y los agentes son herramientas de **defensa**, no de ataque
- Usa este plan solo para **mejorar la seguridad de sistemas que posees o administras**
- El autor de este plan **no se hace responsable** de uso no autorizado

---

## ✅ Próximo Paso

**Confirma tu autorización** respondiendo:

```
"Confirmo que www.mexbalia.com es mi sitio / tengo autorización explícita.
Proceder con el plan de auditoría."
```

Una vez confirmado, iniciamos con la **Fase 1: Reconocimiento Pasivo**.

---

*Plan creado: 2026-04-10 | Versión: 1.0 | Estado: Pendiente de autorización*
