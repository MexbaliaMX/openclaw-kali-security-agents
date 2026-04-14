# RL Safety Guardrails

**Document Type:** Safety Specification  
**Version:** 1.0 (Draft)  
**Date:** April 14, 2026  
**Authors:** Security Engineer, Compliance Auditor  
**Status:** DESIGN PHASE

---

## 🛡️ Overview

This document defines the safety guardrails for the RL mechanism. These guardrails are **hard constraints** — NOT learned, NOT modifiable by RL, and NOT negotiable.

### Key Principles

1. **Safety Over Performance** — Never sacrifice safety for efficiency
2. **Hard Constraints** — Guardrails are rule-based, not learned
3. **Zero Tolerance** — Any violation triggers immediate response
4. **Defense in Depth** — Multiple layers of protection
5. **Human Oversight** — Critical decisions require human approval

---

## 🔒 Guardrail Categories

### Level 1: Absolute Prohibitions (CRITICAL)

These actions are **NEVER** permitted under any circumstances.

| Prohibition | Rationale | Enforcement |
|-------------|-----------|-------------|
| **No Private Data Exfiltration** | User privacy and security | Block + Alert |
| **No Destructive Commands Without Approval** | Prevent accidental damage | Block + Require Approval |
| **No External Actions Without Approval** | Prevent unauthorized communications | Block + Require Approval |
| **No Safety Rule Modification** | Prevent guardrail bypass | Block + Alert |
| **No Self-Replication** | Prevent uncontrolled proliferation | Block + Alert |
| **No Resource Acquisition** | Prevent unauthorized resource use | Block + Alert |
| **No Audit Log Modification** | Preserve audit trail integrity | Block + Alert |
| **No Agent-First Mandate Violation** | Core framework principle | Block + Redirect |

### Level 2: High-Risk Operations (HIGH)

These actions require **explicit human approval** before execution.

| Operation | Approval Required | Rationale |
|-----------|-------------------|-----------|
| External API calls | Per-call | Prevent unauthorized communications |
| File deletion (production) | Per-operation | Prevent data loss |
| System configuration changes | Per-change | Prevent system instability |
| Security testing (production) | Per-test | Prevent service disruption |
| Financial transactions | Per-transaction | Prevent unauthorized spending |
| Policy or rule changes | Per-change | Prevent policy drift |
| RL model updates | Per-update | Prevent model corruption |

### Level 3: Monitored Operations (MEDIUM)

These actions are permitted but **closely monitored** with automatic alerts.

| Operation | Monitoring | Alert Threshold |
|-----------|------------|-----------------|
| Agent spawning | Count per session | >10 sub-agents |
| Task complexity | Complexity score | >0.8 (very complex) |
| Execution time | Duration tracking | >5 minutes |
| Resource usage | CPU/memory/disk | >50% utilization |
| External lookups | Web search, API calls | >20 per hour |

---

## 🚫 Enforcement Mechanisms

### Pre-Execution Checks

```python
def safety_check(task):
    """
    Pre-execution safety validation.
    Returns: (allowed: bool, reason: str, requires_approval: bool)
    """
    
    # Level 1: Absolute Prohibitions
    if violates_absolute_prohibition(task):
        return (False, "Absolute prohibition violated", False)
    
    # Level 2: High-Risk Operations
    if is_high_risk_operation(task):
        return (False, "Requires human approval", True)
    
    # Level 3: Monitored Operations
    if is_monitored_operation(task):
        log_for_monitoring(task)
        return (True, "Allowed with monitoring", False)
    
    # Default: Allow
    return (True, "Safety check passed", False)
```

### Runtime Monitoring

```python
def runtime_monitor(execution):
    """
    Real-time monitoring during task execution.
    Triggers immediate intervention if violations detected.
    """
    
    # Check for prohibited actions
    for action in execution.actions:
        if is_prohibited_action(action):
            execution.interrupt()
            alert_security_team(f"Prohibited action: {action}")
            return False
    
    # Check resource usage
    if execution.resource_usage exceeds_threshold:
        execution.throttle()
        alert_sre(f"Resource threshold exceeded: {execution.resource_usage}")
    
    # Check execution time
    if execution.duration > MAX_ALLOWED_TIME:
        execution.warn()
        log_anomaly(f"Long-running execution: {execution.duration}")
    
    return True
```

### Post-Execution Audit

```python
def post_execution_audit(task_result):
    """
    Post-execution safety and compliance audit.
    """
    
    audit_results = {
        "safety_violations": count_safety_violations(task_result),
        "approval_compliance": verify_approvals(task_result),
        "monitoring_alerts": count_alerts(task_result),
        "audit_completeness": verify_audit_trail(task_result),
    }
    
    if audit_results["safety_violations"] > 0:
        trigger_incident_response(audit_results)
    
    if audit_results["approval_compliance"] < 1.0:
        alert_compliance_team(audit_results)
    
    return audit_results
```

---

## 🚨 Violation Response

### Severity Levels

| Severity | Definition | Response Time | Escalation |
|----------|------------|---------------|------------|
| **CRITICAL** | Absolute prohibition violated | Immediate | User + Security Team |
| **HIGH** | High-risk operation without approval | <1 minute | User |
| **MEDIUM** | Monitored operation anomaly | <5 minutes | SRE |
| **LOW** | Minor policy deviation | <1 hour | Compliance Team |

### Response Procedures

#### CRITICAL Violation Response

```python
def handle_critical_violation(violation):
    # 1. Immediate termination
    violation.execution.terminate()
    
    # 2. Preserve evidence
    violation.preserve_state()
    violation.freeze_logs()
    
    # 3. Alert stakeholders
    alert_user(f"CRITICAL safety violation: {violation.type}")
    alert_security_team(violation)
    alert_compliance_auditor(violation)
    
    # 4. Disable RL (if RL-related)
    if violation.rl_related:
        RL_ORCHESTRATOR.disable()
        alert_project_manager("RL disabled due to safety violation")
    
    # 5. Schedule incident review
    PROJECT_MANAGER.schedule_incident_review(within="24 hours")
```

#### HIGH Violation Response

```python
def handle_high_violation(violation):
    # 1. Block execution
    violation.execution.block()
    
    # 2. Request approval
    request_user_approval(violation)
    
    # 3. Log violation
    log_violation(violation, severity="HIGH")
    
    # 4. Notify user
    notify_user(f"HIGH priority action requires approval: {violation.type}")
```

---

## 📊 Monitoring Dashboard

### Real-Time Metrics

**Safety Metrics:**
- Safety violations (last 24h): Target = 0
- Approval compliance rate: Target = 100%
- Guardrail interactions: Target = 0
- Audit trail completeness: Target = 100%

**Performance Metrics:**
- Task success rate: Target = >95%
- Agent selection accuracy: Target = >90%
- Response time: Target = <2s
- User satisfaction: Target = >4.5/5

**RL-Specific Metrics:**
- Policy entropy: Monitor for collapse
- Reward trends: Monitor for hacking
- Action distribution: Monitor for bias
- Value estimation error: Target = <10%

### Alert Thresholds

| Metric | Warning | Critical | Action |
|--------|---------|----------|--------|
| Safety Violations | N/A | >0 | Immediate rollback |
| Approval Gaps | >1% | >5% | Compliance review |
| Audit Failures | >0.1% | >1% | SRE intervention |
| RL Reward Anomaly | >2σ | >5σ | RL team review |
| User Satisfaction | <4.0 | <3.0 | Product review |

---

## 🔐 Guardrail Implementation

### Technical Controls

#### 1. Immutable Constraint Store

```python
class SafetyConstraintStore:
    """
    Immutable store for safety constraints.
    Cannot be modified by RL or any automated process.
    """
    
    def __init__(self):
        self.constraints = self._load_hardcoded_constraints()
        self.hash = self._compute_hash()
    
    def _load_hardcoded_constraints(self):
        # Loaded from read-only configuration
        return {
            "no_exfiltration": AbsoluteProhibition(),
            "no_destruction_without_approval": HighRiskRequiringApproval(),
            "no_external_without_approval": HighRiskRequiringApproval(),
            "no_guardrail_modification": AbsoluteProhibition(),
            # ... (all constraints hardcoded)
        }
    
    def _compute_hash(self):
        # Hash for integrity verification
        return sha256(str(self.constraints))
    
    def verify_integrity(self):
        # Verify constraints haven't been modified
        current_hash = self._compute_hash()
        assert current_hash == self.hash, "Constraint store integrity violation!"
```

#### 2. Approval Workflow

```python
class ApprovalWorkflow:
    """
    Manages human approval for high-risk operations.
    """
    
    def request_approval(self, task):
        # Create approval request
        request = ApprovalRequest(
            task=task,
            risk_level=self._assess_risk(task),
            rationale=task.description,
            timeout=300,  # 5 minutes
        )
        
        # Send to user
        self._send_approval_request(request)
        
        # Wait for response
        approval = self._wait_for_approval(request)
        
        if not approval.granted:
            task.reject(reason="Approval denied")
            return False
        
        return True
    
    def _assess_risk(self, task):
        # Risk assessment logic
        if task.category in HIGH_RISK_CATEGORIES:
            return "HIGH"
        elif task.category in MEDIUM_RISK_CATEGORIES:
            return "MEDIUM"
        else:
            return "LOW"
```

#### 3. Audit Logger

```python
class AuditLogger:
    """
    Immutable audit logger with tamper-evident logging.
    """
    
    def __init__(self):
        self.log_file = "/var/log/openclaw/audit.log"
        self.hash_chain = []
    
    def log(self, entry):
        # Create log entry
        entry.timestamp = now()
        entry.sequence = len(self.hash_chain)
        entry.previous_hash = self.hash_chain[-1] if self.hash_chain else None
        
        # Compute entry hash
        entry.hash = self._compute_entry_hash(entry)
        
        # Append to chain
        self.hash_chain.append(entry.hash)
        
        # Write to log (append-only)
        self._append_to_log(entry)
    
    def _compute_entry_hash(self, entry):
        return sha256(str(entry))
    
    def verify_integrity(self):
        # Verify entire hash chain
        for i, entry in enumerate(self.log_file):
            if entry.sequence != i:
                return False, f"Sequence mismatch at {i}"
            if i > 0 and entry.previous_hash != self.log_file[i-1].hash:
                return False, f"Hash chain broken at {i}"
        return True, "Audit log integrity verified"
```

---

## 🧪 Testing Requirements

### Guardrail Validation Tests

#### Test 1: Absolute Prohibition Enforcement

```python
def test_absolute_prohibition():
    """
    Verify that absolute prohibitions are enforced.
    """
    
    test_cases = [
        ("exfiltration_attempt", block_and_alert),
        ("destruction_without_approval", block_and_alert),
        ("guardrail_modification", block_and_alert),
        ("self_replication", block_and_alert),
    ]
    
    for action, expected_response in test_cases:
        result = safety_check(action)
        assert result.allowed == False, f"Prohibition not enforced: {action}"
        assert expected_response in result.response, f"Wrong response: {action}"
    
    print("✅ All absolute prohibitions enforced")
```

#### Test 2: Approval Workflow

```python
def test_approval_workflow():
    """
    Verify that high-risk operations require approval.
    """
    
    high_risk_tasks = [
        create_task("delete_production_file"),
        create_task("call_external_api"),
        create_task("modify_system_config"),
    ]
    
    for task in high_risk_tasks:
        result = safety_check(task)
        assert result.requires_approval == True, f"Approval not required: {task}"
        
        # Test without approval
        task.approval = None
        assert not execute(task), "Task executed without approval"
        
        # Test with approval
        task.approval = get_user_approval()
        assert execute(task), "Task failed with approval"
    
    print("✅ Approval workflow functioning correctly")
```

#### Test 3: Audit Trail Integrity

```python
def test_audit_trail_integrity():
    """
    Verify that audit logs are immutable and complete.
    """
    
    # Log some actions
    for i in range(100):
        audit_logger.log(create_log_entry(f"action_{i}"))
    
    # Verify integrity
    integrity_ok, message = audit_logger.verify_integrity()
    assert integrity_ok, f"Audit log integrity failed: {message}"
    
    # Attempt tampering (should fail)
    try:
        tamper_with_log(audit_logger.log_file, entry_index=50)
        assert False, "Log tampering succeeded (should have failed)"
    except TamperDetectionError:
        pass  # Expected
    
    print("✅ Audit trail integrity verified")
```

### Test Coverage Requirements

| Test Category | Minimum Coverage | Target |
|---------------|------------------|--------|
| Absolute Prohibitions | 100% | 100% |
| High-Risk Approval | 100% | 100% |
| Monitoring Alerts | 95% | 100% |
| Audit Logging | 100% | 100% |
| RL Integration | 90% | 95% |
| Rollback Procedures | 100% | 100% |

---

## 📋 Compliance Checklist

### Pre-Implementation

- [ ] All absolute prohibitions documented
- [ ] All high-risk operations identified
- [ ] Approval workflow implemented
- [ ] Audit logger tested
- [ ] Monitoring dashboard configured
- [ ] Alert thresholds set
- [ ] Rollback procedure tested

### Post-Implementation

- [ ] Daily safety metric review (first 2 weeks)
- [ ] Weekly compliance audit (first month)
- [ ] Monthly security review (ongoing)
- [ ] Quarterly guardrail update review (ongoing)

### Ongoing Requirements

- [ ] Zero safety violations (target)
- [ ] 100% approval compliance (required)
- [ ] 100% audit trail completeness (required)
- [ ] <1% monitoring alerts (target)

---

## 🔗 Related Documents

| Document | Location | Relationship |
|----------|----------|--------------|
| RL Mechanism Design | `docs/agents/RL-Mechanism-Design.md` | Parent document |
| Agent-First Mandate | `AGENTS.md` | Guardrail enforces this |
| Security Framework | `docs/security-operations/` | Aligned with security policies |
| Compliance Procedures | `docs/compliance/` | Compliance requirements |
| Incident Response | `docs/security-operations/Incident-Response.md` | Violation response |

---

## ✅ Approval

**Reviewed By:**
- [ ] Security Engineer
- [ ] Compliance Auditor
- [ ] Workflow Architect
- [ ] User (Wulfrano)

**Approved For Implementation:** [ ] Yes [ ] No [ ] Pending Changes

**Approval Date:** _______________

**Next Review Date:** _______________ (Quarterly)

---

**Document Status:** DRAFT — Pending Approval  
**Classification:** INTERNAL — SAFETY CRITICAL
