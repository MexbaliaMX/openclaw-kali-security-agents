# Blockchain Security Auditor - Kali Linux Tool Mapping

**Agent:** 🛡️ Blockchain Security Auditor  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 32  
**Status:** Complete

---

## Overview

**Mission:** Smart contract auditing, DeFi vulnerability detection, blockchain security analysis, and exploit research.

**Primary Use Cases:**
- Smart contract security auditing
- DeFi protocol analysis
- Blockchain vulnerability research
- Exploit development and analysis
- Token security assessment
- Web3 security consulting

---

## 1. Smart Contract Analysis

### Static Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **slither** | slither-analyzer (pip) | Solidity static analysis | `slither ./contracts` |
| **mythril** | mythril (pip) | Security analysis | `myth analyze contract.sol` |
| **manticore** | manticore (pip) | Symbolic execution | `manticore contract.sol` |
| **securify** | securify (manual) | Security scanner | Web interface |
| **smartcheck** | smartcheck (web) | Static analyzer | Web interface |
| **solhint** | solhint (npm) | Solidity linter | `solhint contracts/*.sol` |

### Slither Usage Examples
```bash
# Run all detectors
slither ./contracts

# Run specific detector
slither ./contracts --detect reentrancy

# Generate report
slither ./contracts --json output.json

# Print inheritance
slither ./contracts --print inheritance

# Print function summary
slither ./contracts --print contract-summary

# Detectors by impact
slither ./contracts --check-assertion
slither ./contracts --detect uninitialized-state
```

### Mythril Examples
```bash
# Analyze contract
myth analyze contract.sol

# Analyze bytecode
myth analyze 0x1234567890abcdef

# Generate report
myth analyze contract.sol -o json > report.json

# Specific checks
myth analyze contract.sol --modules reentrancy,integer_overflow
```

---

## 2. Fuzzing & Testing

### Fuzzing Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **echidna** | echidna (manual) | Property fuzzer | `echidna-test contracts` |
| **foundry** | foundry (manual) | Development framework | `forge test --fuzz` |
| **hardhat** | hardhat (npm) | Development environment | `npx hardhat test` |
| **brownie** | brownie (pip) | Python framework | `brownie test` |

### Echidna Usage
```bash
# Initialize
echidna-test . --config config.yaml

# Run specific property
echidna-test . --property testBalance

# Run with corpus
echidna-test . --test-mode assertion --corpus-dir corpus

# Generate corpus
echidna-test . --test-mode assertion --save-corpus
```

### Foundry Fuzzing
```bash
# Run tests with fuzzing
forge test --fuzz

# Increase fuzz runs
forge test --fuzz-runs 1000

# Verbosity
forge test -vvv

# Gas report
forge test --gas-report
```

---

## 3. Formal Verification

### Verification Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **certora** | certora (manual) | Formal verification | `certoraRun spec.sol` |
| **k-framework** | k-framework (manual) | Formal semantics | `k spec.k` |
| **verx** | verx (manual) | Verification tool | Research tool |

---

## 4. Exploit Development

### Exploit Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **brownie** | brownie (pip) | Exploit development | `brownie run exploit.py` |
| **web3.py** | web3.py (pip) | Ethereum library | Python integration |
| **ethers.js** | ethers.js (npm) | Ethereum library | JavaScript integration |
| **cast** | foundry (manual) | CLI tool | `cast call 0xcontract` |

### Brownie Exploit Template
```python
# exploit.py
from brownie import accounts, Contract

def exploit():
    # Connect to contract
    contract = Contract.from_explorer("0x...")
    
    # Execute exploit
    attacker = accounts[0]
    contract.vulnerableFunction(
        {"from": attacker, "value": "1 ether"}
    )
    
    # Verify results
    print(f"Attacker balance: {contract.balanceOf(attacker)}")

exploit()
```

---

## 5. DeFi Analysis

### DeFi Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **defi-exploits** | defi-exploits (github) | Exploit database | GitHub repository |
| **tenderly** | tenderly (web) | Simulation platform | Web interface |
| **alchemy** | alchemy (web) | Blockchain API | API integration |
| **defipulse** | defipulse (web) | DeFi analytics | Web interface |

---

## 6. Token Analysis

### Token Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **token-sniffer** | token-sniffer (web) | Token analysis | Web interface |
| **honeypot-checker** | honeypot-checker (manual) | Honeypot detection | Web/CLI |
| **erc20-analyzer** | erc20-analyzer (manual) | ERC20 analysis | Custom scripts |

---

## 7. Blockchain Forensics

### On-Chain Analysis

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **etherscan** | etherscan (web) | Block explorer | Web interface |
| **blockscout** | blockscout (manual) | Block explorer | Self-hosted |
| **graph-protocol** | graph-protocol (manual) | Indexing | GraphQL queries |
| **dune** | dune (web) | Analytics platform | SQL queries |

### Dune Analytics Query
```sql
-- Track token transfers
SELECT 
    evt_tx_hash,
    evt_block_time,
    from_address,
    to_address,
    value / 1e18 as amount
FROM erc20_evt_transfer
WHERE contract_address = 0x...
ORDER BY evt_block_time DESC
```

---

## 8. Security Resources

### Vulnerability Databases

| Resource | Type | URL |
|----------|------|-----|
| **SWC Registry** | Vulnerability DB | https://swcregistry.io |
| **Smart Contract Weaknesses** | Classification | https://smartcontractweaknesses.org |
| **Rekt News** | Exploit Reports | https://rekt.news |
| **Immunefi** | Bug Bounty | https://immunefi.com |

---

## Top 10 Blockchain Security Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Slither** | Analysis | Best static analyzer |
| 2 | **Mythril** | Analysis | Comprehensive security scanner |
| 3 | **Foundry** | Testing | Modern development framework |
| 4 | **Echidna** | Fuzzing | Property-based fuzzing |
| 5 | **Manticore** | Analysis | Symbolic execution |
| 6 | **Brownie** | Development | Python-based framework |
| 7 | **Hardhat** | Development | Industry-standard environment |
| 8 | **Tenderly** | Simulation | Transaction simulation |
| 9 | **Solhint** | Linting | Code quality |
| 10 | **SWC Registry** | Reference | Vulnerability reference |

---

## Quick Reference Commands

### Smart Contract Audit Workflow
```bash
# 1. Static analysis
slither ./contracts --json slither.json
myth analyze contract.sol -o json > myth.json

# 2. Linting
solhint contracts/*.sol

# 3. Fuzzing
echidna-test . --config config.yaml

# 4. Unit tests
forge test -vvv

# 5. Generate report
# Aggregate findings from all tools
```

### Common Vulnerability Checks
```bash
# Reentrancy
slither ./contracts --detect reentrancy

# Integer overflow
slither ./contracts --detect integer-overflow

# Access control
slither ./contracts --detect unprotected-functions

# Front-running
slither ./contracts --detect front-running

# Timestamp dependence
slither ./contracts --detect timestamp
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Analysis** | Slither, Mythril, Manticore |
| **Development** | Brownie, Web3.py |
| **Testing** | Pytest |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **Foundry** | curl/foundryup | Modern framework |
| **Hardhat** | npm | Development environment |
| **Echidna** | GitHub releases | Fuzzing tool |
| **Certora** | Web platform | Formal verification |
| **Tenderly** | Web platform | Simulation |
| **Solhint** | npm | Solidity linter |

---

## Audit Checklist

### Pre-Audit
- [ ] Understand contract functionality
- [ ] Review documentation
- [ ] Set up development environment
- [ ] Configure analysis tools

### Static Analysis
- [ ] Run Slither (all detectors)
- [ ] Run Mythril
- [ ] Run Solhint
- [ ] Review findings

### Dynamic Analysis
- [ ] Run unit tests
- [ ] Run fuzzing (Echidna)
- [ ] Manual testing
- [ ] Edge case testing

### Reporting
- [ ] Document all findings
- [ ] Assign severity ratings
- [ ] Provide remediation
- [ ] Create executive summary

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly  
**Owner:** Security Team
