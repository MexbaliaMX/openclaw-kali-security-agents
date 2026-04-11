# OWASP MCP Security Guide - Summary

**Source:** OWASP GenAI Security Project  
**Document:** A Practical Guide for Secure MCP Server Development v1.0  
**Date:** February 2026  
**License:** CC BY-SA 4.0

---

## Overview

Model Context Protocol (MCP) servers act as bridges between AI assistants and external tools/data sources. Security gaps can allow attackers to:
- Manipulate AI assistants
- Steal sensitive information
- Compromise downstream systems

MCP servers are unique because they operate with:
- Delegated user permissions
- Dynamic tool-based architectures
- Ability to chain multiple tool calls (amplifying impact of vulnerabilities)

---

## 8 Core Security Areas

### 1. Secure MCP Architecture
- Design with least privilege principles
- Isolate tool execution environments
- Implement defense in depth

### 2. Safe Tool Design
- One responsibility per tool
- Clear, unambiguous tool names
- Typed parameters with validation
- Structured output (JSON for data, markdown for human content)

### 3. Data Validation & Resource Management
- Input validation at boundaries
- Proper error handling (no stack traces)
- Resource cleanup on failure
- Stateless tool operations

### 4. Prompt Injection Controls
- Validate and sanitize all inputs
- Implement content filtering
- Use allowlists where possible
- Monitor for injection patterns

### 5. Authentication & Authorization
- API keys from environment variables (never hardcoded)
- OAuth with proper token refresh
- Scoped permissions
- Verify caller authentication on every request

### 6. Secure Deployment & Updates
- Sandboxed execution environments
- Read-only tokens by default
- Secure update mechanisms
- Version pinning for dependencies

### 7. Governance
- Security review for new tools
- Audit logging
- Incident response procedures
- Regular security assessments

### 8. Tools & Continuous Validation
- Automated security testing
- Regular penetration testing
- Monitor for anomalous tool usage
- Keep dependencies updated

---

## MCP Security Minimum Bar (Checklist)

- [ ] Tool names are descriptive and unambiguous
- [ ] All parameters are typed and validated
- [ ] Error responses are actionable (no stack traces)
- [ ] Secrets come from environment variables
- [ ] Tools are stateless
- [ ] Authentication verified on every call
- [ ] Audit logging enabled
- [ ] Sandboxed execution environment
- [ ] Regular security reviews scheduled

---

## Common Vulnerabilities to Watch For

1. **Prompt Injection** - Malicious input manipulating tool behavior
2. **Excessive Permissions** - Tools with more access than needed
3. **Insecure Defaults** - Tools that are too permissive by default
4. **Data Leakage** - Sensitive data exposed in tool responses
5. **Tool Chaining Attacks** - Combining tools to bypass security controls
6. **Supply Chain Risks** - Compromised dependencies or updates

---

## Location

- **PDF:** `/home/kali/.openclaw/workspace/docs/mcp-security/OWASP-MCP-Security-Guide-v1.0.pdf`
- **Full Text:** https://genai.owasp.org (OWASP GenAI Security Project)

---

## Related Resources

- OWASP Top 10 for LLMs
- OWASP GenAI Red Teaming Guide
- MCP Protocol Specification

---

*Saved: 2026-04-10 by KaliKlaw*
