# MCP Builder - Kali Linux Tool Mapping

**Agent:** 🔌 MCP Builder  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 22  
**Status:** Complete

---

## Overview

**Mission:** Model Context Protocol server development, custom AI tool creation, and secure AI integration.

**Primary Use Cases:**
- MCP server development
- AI tool integration
- Secure API development
- AI security implementation
- Tool testing and validation
- Documentation and deployment

---

## 1. Development Environment

### IDE & Editors

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **vscode** | code (manual) | Code editor | `code .` |
| **vim** | vim | Terminal editor | `vim file.py` |
| **neovim** | neovim | Modern vim | `nvim file.py` |
| **cursor** | cursor (manual) | AI-powered editor | GUI application |

### Version Control

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **git** | git | Version control | `git commit -m "message"` |
| **github-cli** | gh | GitHub CLI | `gh pr create` |
| **gitlab-cli** | glab | GitLab CLI | `glab mr create` |

---

## 2. API Development

### API Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **fastapi** | fastapi (pip) | API framework | `uvicorn main:app --reload` |
| **flask** | flask (pip) | Web framework | `flask run` |
| **httpie** | httpie (pip) | HTTP client | `http POST localhost:8000/api` |
| **curl** | curl | HTTP requests | `curl -X POST http://localhost:8000/api` |
| **postman** | postman (manual) | API testing | GUI application |
| **insomnia** | insomnia (manual) | API client | GUI application |

### FastAPI MCP Template
```python
# mcp_server.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class MCPRequest(BaseModel):
    tool: str
    params: dict

class MCPResponse(BaseModel):
    success: bool
    result: any
    error: str = None

@app.post("/mcp/tools/invoke")
async def invoke_tool(request: MCPRequest) -> MCPResponse:
    try:
        # Tool invocation logic
        result = await execute_tool(request.tool, request.params)
        return MCPResponse(success=True, result=result)
    except Exception as e:
        return MCPResponse(success=False, result=None, error=str(e))

@app.get("/mcp/tools/list")
async def list_tools() -> list:
    return [
        {"name": "security_scan", "description": "Run security scan"},
        {"name": "vuln_check", "description": "Check vulnerabilities"}
    ]
```

---

## 3. Security Testing

### Security Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **semgrep** | semgrep | Static analysis | `semgrep --config auto/ .` |
| **bandit** | bandit (pip) | Python security | `bandit -r ./mcp_server` |
| **trivy** | trivy | Vulnerability scanner | `trivy fs ./project` |
| **safety** | safety (pip) | Dependency check | `safety check` |
| **pip-audit** | pip-audit (pip) | pip audit | `pip-audit` |

### OWASP MCP Security Implementation
```python
# security_middleware.py
from fastapi import Request, HTTPException
import logging

# Authentication
async def verify_api_key(request: Request):
    api_key = request.headers.get("X-API-Key")
    if not api_key or api_key != EXPECTED_KEY:
        raise HTTPException(status_code=401, detail="Invalid API key")

# Rate limiting
from slowapi import Limiter
limiter = Limiter(key_func=get_remote_address)

# Input validation
from pydantic import validator

class ToolInput(BaseModel):
    tool_name: str
    parameters: dict
    
    @validator('tool_name')
    def validate_tool_name(cls, v):
        if not v.isalnum():
            raise ValueError("Tool name must be alphanumeric")
        return v

# Audit logging
def log_tool_invocation(tool: str, params: dict, user: str):
    logging.info(f"Tool invocation: {tool} by {user}")
```

---

## 4. Container & Deployment

### Containerization

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **docker** | docker | Containerization | `docker build -t mcp-server .` |
| **docker-compose** | docker-compose | Multi-container | `docker-compose up` |
| **podman** | podman | Container engine | `podman build -t mcp-server .` |

### Docker Example
```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Docker Compose
```yaml
# docker-compose.yml
version: '3.8'
services:
  mcp-server:
    build: .
    ports:
      - "8000:8000"
    environment:
      - API_KEY=${API_KEY}
      - LOG_LEVEL=INFO
    volumes:
      - ./logs:/app/logs
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

---

## 5. Testing & QA

### Testing Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **pytest** | pytest | Testing framework | `pytest -v tests/` |
| **httpx** | httpx (pip) | HTTP testing | Python library |
| **locust** | locust (pip) | Load testing | `locust -f locustfile.py` |
| **black** | black (pip) | Code formatting | `black .` |
| **flake8** | flake8 (pip) | Linting | `flake8 .` |
| **mypy** | mypy (pip) | Type checking | `mypy .` |

### Pytest Example
```python
# test_mcp.py
import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_list_tools():
    response = client.get("/mcp/tools/list")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_invoke_tool():
    response = client.post(
        "/mcp/tools/invoke",
        json={"tool": "security_scan", "params": {}}
    )
    assert response.status_code == 200
    assert response.json()["success"] == True

def test_invalid_api_key():
    response = client.post(
        "/mcp/tools/invoke",
        json={"tool": "security_scan", "params": {}},
        headers={"X-API-Key": "invalid"}
    )
    assert response.status_code == 401
```

---

## 6. Documentation

### Documentation Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **mkdocs** | mkdocs (pip) | Documentation | `mkdocs serve` |
| **sphinx** | sphinx (pip) | Documentation | `sphinx-build docs/ build/` |
| **pdoc** | pdoc (pip) | API docs | `pdoc ./mcp_server` |

---

## Top 10 MCP Builder Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **FastAPI** | Framework | Modern API framework |
| 2 | **Semgrep** | Security | Static analysis |
| 3 | **Docker** | Deployment | Containerization |
| 4 | **Pytest** | Testing | Testing framework |
| 5 | **Bandit** | Security | Python security |
| 6 | **Trivy** | Security | Vulnerability scanning |
| 7 | **Git** | Version Control | Source control |
| 8 | **HTTPie** | Testing | API testing |
| 9 | **Black** | Quality | Code formatting |
| 10 | **MkDocs** | Documentation | Documentation generation |

---

## Quick Reference Commands

### Development Workflow
```bash
# Set up environment
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run development server
uvicorn main:app --reload

# Run tests
pytest -v tests/

# Security scanning
semgrep --config auto/ .
bandit -r ./mcp_server
trivy fs .

# Build container
docker build -t mcp-server .
docker-compose up
```

### API Testing
```bash
# List tools
curl http://localhost:8000/mcp/tools/list

# Invoke tool
curl -X POST http://localhost:8000/mcp/tools/invoke \
  -H "Content-Type: application/json" \
  -H "X-API-Key: your-key" \
  -d '{"tool": "security_scan", "params": {}}'

# Health check
curl http://localhost:8000/health
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Development** | Python, Git, Vim |
| **Security** | Semgrep, Bandit, Trivy |
| **Testing** | Pytest |
| **Container** | Docker |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **FastAPI** | pip | API framework |
| **VS Code** | Download | Code editor |
| **Postman** | Download/Snap | API testing |
| **Insomnia** | Download | API client |
| **MkDocs** | pip | Documentation |
| **Docker Compose** | apt | Multi-container |

---

## MCP Security Checklist

### Authentication & Authorization
- [ ] API key validation
- [ ] OAuth2 integration (if needed)
- [ ] Role-based access control
- [ ] Token expiration

### Input Validation
- [ ] Schema validation (Pydantic)
- [ ] Input sanitization
- [ ] Parameter type checking
- [ ] Length limits

### Audit Logging
- [ ] Tool invocation logging
- [ ] User activity tracking
- [ ] Error logging
- [ ] Security event logging

### Rate Limiting
- [ ] Per-user rate limits
- [ ] Per-tool rate limits
- [ ] Global rate limits
- [ ] Burst protection

### Deployment Security
- [ ] Secrets management
- [ ] TLS/HTTPS
- [ ] Container hardening
- [ ] Network segmentation

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly  
**Owner:** Security Team
