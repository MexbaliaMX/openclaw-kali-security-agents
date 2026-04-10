# KaliKlaw Agents

Specialized AI agent configurations adapted from [agency-agents](https://github.com/msitarzewski/agency-agents) for OpenClaw on Kali Linux.

## Available Agents

### 🔒 Security-Focused

| Agent | Activate | Purpose |
|-------|----------|---------|  
| **Security Engineer** | "Activate Security Engineer mode" | Threat modeling, vulnerability assessment, secure architecture, security audits |
| **Incident Response Commander** | "Activate Incident Response mode" | Production incident management, post-mortems, runbooks, on-call processes |
| **Code Reviewer** | "Activate Code Reviewer mode" | Security-focused code reviews, PR feedback, vulnerability detection |
| **Threat Detection Engineer** | "Activate Threat Detection mode" | SIEM rules (Sigma/SPL/KQL), MITRE ATT&CK mapping, threat hunting playbooks |
| **SRE** | "Activate SRE mode" | SLOs, error budgets, observability, toil reduction, capacity planning |
| **Compliance Auditor** | "Activate Compliance Auditor mode" | SOC 2, ISO 27001, HIPAA, PCI-DSS readiness, gap assessments, evidence collection |
| **Technical Writer** | "Activate Technical Writer mode" | README files, API docs, tutorials, documentation audits, docs-as-code |

## How to Use

Activate any agent by saying:
- "Activate [Agent Name] mode"
- "Switch to [Agent Name] mode"
- "Review this as a [Agent Name]"

Example:
> "Activate Security Engineer mode and review this API endpoint for vulnerabilities"

## Agent Principles

All agents follow KaliKlaw's core identity:

- **Methodical**: Precision over speed. Thoroughness over shortcuts.
- **Security-minded**: Default deny, least privilege, defense in depth
- **Pragmatic**: Risk reduction over perfection, developer experience over security theater
- **Educational**: Every interaction should teach something

## File Structure

```
agents/
├── README.md                    # This file
├── security-engineer.md         # Security architecture & audits
├── incident-response.md         # Incident management & post-mortems
├── code-reviewer.md             # Code review with security focus
├── threat-detection.md          # SIEM rules & threat hunting
└── sre.md                       # Reliability engineering
```

## Adding New Agents

When implementing new agents from agency-agents or other sources:

1. Adapt the format to match existing agents
2. Keep the identity/mission/rules/deliverables structure
3. Ensure alignment with KaliKlaw's methodical, security-focused identity
4. Add to this README's table

---

*Built for methodical, security-focused operations on Kali Linux.*
