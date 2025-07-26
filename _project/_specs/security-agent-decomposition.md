# Security Agent Decomposition Architecture

## Overview

Transform the monolithic security-quality-scanner into specialized, parallel-executing security agents for improved performance and modularity.

## Current State Analysis

**Monolithic Agent Issues:**
- Single agent handles 8+ distinct security domains
- Sequential execution causes long wait times
- Mixed responsibilities reduce focus and expertise
- Difficult to maintain and extend

**Scope Breakdown:**
- Vulnerability detection (injection, XSS, CSRF)
- Secret and credential scanning
- Authentication/authorization review
- Code quality assessment
- Dependency security analysis
- Accessibility compliance
- Input validation assessment
- Error handling analysis

## Target Architecture

### Tier 1: Fast Pattern-Based Agents

**vulnerability-scanner** 🛡️
```yaml
focus: Attack vector detection
patterns:
  - SQL injection indicators
  - XSS vulnerability patterns  
  - Command injection risks
  - Path traversal attempts
  - CSRF protection gaps
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/vulnerability-findings.json
execution_time: 30-60 seconds
```

**secrets-detector** 🔐
```yaml
focus: Credential exposure
patterns:
  - API keys (AWS, GitHub, etc.)
  - Database passwords
  - JWT tokens
  - Private keys
  - Environment variable leaks
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/secrets-findings.json
execution_time: 30-60 seconds
```

**input-validation-scanner** 🛑
```yaml
focus: Data sanitization
patterns:
  - Unvalidated user input
  - Missing output encoding
  - Unsafe deserialization
  - File upload vulnerabilities
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/input-validation-findings.json
execution_time: 30-60 seconds
```

### Tier 2: Logic Analysis Agents

**auth-security-analyzer** 👤
```yaml
focus: Authentication & authorization
analysis:
  - Session management
  - Password policies
  - Multi-factor authentication
  - Role-based access control
  - JWT implementation
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/auth-findings.json
execution_time: 2-4 minutes
```

**cryptographic-security-auditor** 🔒
```yaml
focus: Cryptographic implementation
analysis:
  - Encryption algorithms
  - Key management
  - Random number generation
  - Certificate validation
  - TLS configuration
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/cryp-sec-findings.json
execution_time: 2-4 minutes
```

**error-handling-analyzer** ⚠️
```yaml
focus: Information disclosure
analysis:
  - Error message content
  - Stack trace exposure
  - Debug information leaks
  - Logging sensitive data
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/error-handling-findings.json
execution_time: 2-4 minutes
```

### Tier 3: External Dependency Agents

**dependency-security-scanner** 📦🛡️
```yaml
focus: Security vulnerabilities in dependencies
analysis:
  - CVE database checks
  - Security advisories
  - Known vulnerability patterns
  - Supply chain security risks
  - Malicious package detection
tools: [Read, Glob, Grep, LS, Write, MultiEdit, Bash]
output: security/dependency-findings.json
execution_time: 3-6 minutes
```

**dependency-lifecycle-manager** 📦⚙️
```yaml
focus: Dependency health and optimization
analysis:
  - Update status and maintenance activity
  - Community health metrics
  - License compliance and compatibility
  - Unused dependency detection
  - Bundle size impact analysis
  - Duplicate dependency identification
  - Version conflict resolution
  - Alternative package recommendations
tools: [Read, Glob, Grep, LS, Write, MultiEdit, Bash]
output: dependencies/lifecycle-analysis.json
execution_time: 2-4 minutes
```

**container-security-auditor** 🐳
```yaml
focus: Container & infrastructure
analysis:
  - Dockerfile security
  - Container image vulnerabilities
  - Runtime security configs
  - Secrets in containers
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/container-findings.json
execution_time: 3-6 minutes
```

### Tier 4: Specialized Domain Agents

**accessibility-security-auditor** ♿
```yaml
focus: Accessibility & UX security
analysis:
  - WCAG 2.1 AA compliance
  - ARIA implementation
  - Keyboard navigation security
  - Screen reader compatibility
  - Focus management
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/accessibility-findings.json
execution_time: 2-5 minutes
```

**api-security-analyzer** 🌐
```yaml
focus: API endpoint security
analysis:
  - REST API vulnerabilities
  - GraphQL security
  - Rate limiting
  - CORS configuration
  - API authentication
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/api-findings.json
execution_time: 2-5 minutes
```

**mobile-security-scanner** 📱
```yaml
focus: Mobile app security
analysis:
  - Platform-specific vulnerabilities
  - Deep link security
  - Local storage security
  - Certificate pinning
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: security/mobile-findings.json
execution_time: 2-5 minutes
```

## Execution Orchestration

### Parallel Execution Groups

```yaml
execution_plan:
  tier_1_fast:
    parallel: [vulnerability-scanner, secrets-detector, input-validation-scanner]
    
  tier_2_logic:
    parallel: [auth-security-analyzer, cryptographic-security-auditor, error-handling-analyzer]
    depends_on: tier_1_fast
    
  tier_3_external:
    parallel: [dependency-security-scanner, dependency-lifecycle-manager, container-security-auditor]
    depends_on: tier_1_fast
    
  tier_4_specialized:
    parallel: [accessibility-security-auditor, api-security-analyzer, mobile-security-scanner]
    depends_on: tier_2_logic

  consolidation:
    agent: security-report-consolidator
    depends_on: [tier_1_fast, tier_2_logic, tier_3_external, tier_4_specialized]
```

### Adaptive Execution

```bash
# Intelligent agent selection based on project type
detect_project_type() {
  if [[ -f "package.json" ]]; then AGENTS+="api-security-analyzer "
  if [[ -f "Dockerfile" ]]; then AGENTS+="container-security-auditor "
  if [[ -d "mobile/" ]]; then AGENTS+="mobile-security-scanner "
  if [[ -d "public/" ]]; then AGENTS+="accessibility-security-auditor "
}
```

### Resource Management

```yaml
concurrency_limits:
  max_parallel_agents: 6
  memory_per_agent: "512MB" 
  cpu_per_agent: "1 core"
  
fallback_strategy:
  if_timeout: "Continue with partial results"
  if_memory_limit: "Run agents sequentially"
  if_error: "Skip failed agent, continue others"
```

## Standardized Output Format

### Agent Output Schema

```json
{
  "metadata": {
    "agent": "vulnerability-scanner",
    "version": "1.0.0",
    "execution_time": "45s",
    "scan_scope": ["src/", "lib/", "config/"],
    "analysis_date": "2025-07-26T10:30:00Z"
  },
  "summary": {
    "total_issues": 12,
    "critical_issues": 2,
    "high_issues": 4,
    "medium_issues": 4,
    "low_issues": 2,
    "score": 7.2
  },
  "findings": [
    {
      "id": "VUL-001",
      "title": "SQL Injection in User Query",
      "severity": "critical",
      "category": "injection",
      "description": "Unsanitized user input in database query",
      "location": {"file": "src/auth/login.js", "line": 45},
      "evidence": "const query = `SELECT * FROM users WHERE id = ${userId}`",
      "impact": "Full database compromise possible",
      "remediation": "Use parameterized queries or ORM",
      "effort": "low",
      "cwe": "CWE-89"
    }
  ]
}
```

### Shared Configuration

```yaml
base_config:
  ignore_patterns: ["_project", ".claude", "node_modules", ".git"]
  file_size_limit: "10MB"
  timeout: "10m"
  output_format: "json+markdown"
  
security_patterns:
  critical_keywords: ["password", "secret", "key", "token", "api_key"]
  injection_patterns: ["SELECT.*FROM", "eval\\(", "exec\\("]
  xss_patterns: ["innerHTML", "outerHTML", "document.write"]
```

## Consolidation Strategy

### Security Report Consolidator Agent

```yaml
security-report-consolidator:
  icon: 📋
  purpose: Merge specialized security findings into unified report
  inputs:
    - security/vulnerability-findings.json
    - security/secrets-findings.json  
    - security/auth-findings.json
    - security/cryp-sec-findings.json
    - security/dependency-findings.json
    - dependencies/lifecycle-analysis.json
    - security/accessibility-findings.json
    - security/api-findings.json
    - security/container-findings.json
    - security/mobile-findings.json
    - security/error-handling-findings.json
    - security/input-validation-findings.json
  
  outputs:
    - security/consolidated-findings.json
    - security/executive-summary.md
    - security/detailed-report.md
    - security/remediation-roadmap.md
```

### Output Directory Structure

```
security/
├── consolidated-findings.json      # Main dashboard source
├── executive-summary.md           # High-level overview
├── detailed-report.md             # Technical deep-dive
├── remediation-roadmap.md         # Prioritized action plan
│
├── specialized/                   # Individual agent outputs
│   ├── vulnerability-findings.json
│   ├── secrets-findings.json
│   ├── auth-findings.json
│   ├── cryp-sec-findings.json
│   ├── dependency-findings.json
│   ├── accessibility-findings.json
│   ├── api-findings.json
│   ├── container-findings.json
│   ├── mobile-findings.json
│   ├── error-handling-findings.json
│   └── input-validation-findings.json
│
└── metrics/
    ├── security-score.json        # Overall security posture
    ├── trend-analysis.json        # Change over time
    └── compliance-status.json     # Standards adherence

dependencies/
├── lifecycle-analysis.json        # Comprehensive dependency health
├── dependency-risk-matrix.json    # Risk assessment matrix
├── update-priority-list.json      # Prioritized update recommendations
├── license-compliance-report.json # License compatibility analysis
├── bundle-optimization.json       # Performance optimization suggestions
└── alternative-packages.json      # Package replacement recommendations

quality/
├── code-analysis.json             # Code quality and maintainability metrics
├── technical-debt.json            # Technical debt inventory and priorities
├── testing-strategy.json          # Test coverage and quality assessment
├── documentation-gaps.json        # Documentation completeness analysis
├── refactoring-roadmap.json       # Prioritized refactoring recommendations
└── quality-consolidated.json      # Unified quality report
```

## Dashboard Integration

### Updated Dashboard Structure

```javascript
dashboard_structure: {
  "Executive Summary": {
    source: "security/consolidated-findings.json",
    displays: ["risk_score", "critical_count", "top_priorities"]
  },
  
  "Vulnerability Analysis": {
    source: "security/vulnerability-findings.json", 
    displays: ["injection_attacks", "xss_risks", "csrf_issues"]
  },
  
  "Secrets & Credentials": {
    source: "security/secrets-findings.json",
    displays: ["exposed_keys", "hardcoded_passwords", "env_leaks"]
  },
  
  "Authentication & Access": {
    source: "security/auth-findings.json",
    displays: ["session_security", "access_controls", "mfa_status"]
  },
  
  "Cryptography": {
    source: "security/cryp-sec-findings.json",
    displays: ["encryption_status", "key_management", "tls_config"]
  },
  
  "Dependency Security": {
    source: "security/dependency-findings.json",
    displays: ["cve_vulnerabilities", "security_advisories", "supply_chain_risks"]
  },
  
  "Dependency Management": {
    source: "dependencies/lifecycle-analysis.json",
    displays: ["update_status", "bundle_optimization", "license_compliance", "health_metrics"]
  },
  
  "API Security": {
    source: "security/api-findings.json",
    displays: ["endpoint_security", "cors_config", "rate_limiting"]
  },
  
  "Accessibility": {
    source: "security/accessibility-findings.json",
    displays: ["wcag_compliance", "aria_implementation", "keyboard_nav"]
  },
  
  "Code Quality": {
    source: "quality/code-analysis.json",
    displays: ["maintainability_score", "complexity_metrics", "testing_coverage", "documentation_status"]
  },
  
  "Technical Debt": {
    source: "quality/technical-debt.json", 
    displays: ["debt_inventory", "refactoring_priorities", "performance_issues", "legacy_patterns"]
  }
}
```

## Non-Security Quality Agents

### **code-quality-analyzer** 🧪
```yaml
focus: Code maintainability and technical excellence
analysis:
  - SOLID principles adherence
  - DRY violations and code duplication
  - Coupling and cohesion metrics
  - Cyclomatic complexity analysis
  - Testing coverage and quality patterns
  - E2E vs unit test balance assessment
  - README and documentation completeness
  - API documentation coverage
  - Architecture decision records
  - Dead code identification
  - Refactoring opportunities
tools: [Read, Glob, Grep, LS, Write, MultiEdit, Bash]
output: quality/code-analysis.json
execution_time: 3-5 minutes
```

### **technical-debt-assessor** 🔧
```yaml
focus: Technical debt identification and prioritization
analysis:
  - Developer comment analysis (TODO, FIXME, HACK)
  - Performance bottlenecks and inefficiencies
  - Architectural improvement areas
  - Legacy code pattern identification
  - Maintenance burden assessment
tools: [Read, Glob, Grep, LS, Write, MultiEdit]
output: quality/technical-debt.json
execution_time: 2-4 minutes
```

## Implementation Order

### Core Security Foundation
1. **vulnerability-scanner** - Critical attack vectors
2. **secrets-detector** - Credential exposure
3. **input-validation-scanner** - Data sanitization

### Authentication & Cryptography
4. **auth-security-analyzer** - Authentication mechanisms
5. **cryptographic-security-auditor** - Cryptographic implementation

### External Dependencies
6. **dependency-security-scanner** - Security vulnerabilities in dependencies
7. **dependency-lifecycle-manager** - Dependency health and optimization
8. **container-security-auditor** - Infrastructure security

### Specialized Domains
9. **api-security-analyzer** - API endpoint security
10. **accessibility-security-auditor** - WCAG compliance
11. **error-handling-analyzer** - Information disclosure
12. **mobile-security-scanner** - Mobile app security

### Quality Analysis
13. **code-quality-analyzer** - Code maintainability and excellence
14. **technical-debt-assessor** - Technical debt identification

### Consolidation
15. **security-report-consolidator** - Unified security reporting
16. **quality-report-consolidator** - Unified quality reporting

## Benefits

- **Performance**: 50% faster execution through parallelization
- **Modularity**: Specialized expertise per security domain
- **Scalability**: Easy to add new security domains
- **Maintainability**: Individual agent updates without affecting others
- **User Experience**: Progressive results every 1-2 minutes
- **Granular Reporting**: Targeted remediation guidance
- **Resource Efficiency**: Optimal resource utilization across cores

## Migration Strategy

### Agent Replacement
- Replace single `security-quality-scanner` with specialized agents
- Update `repo_review.md` command to execute new agent set
- Modify dashboard to consume multiple security report sources

### Backward Compatibility
- Maintain consolidated output format for existing integrations
- Preserve existing dashboard navigation structure
- Keep executive summary aggregation behavior

### Quality Separation
- Create dedicated `code-quality-analyzer` for comprehensive quality analysis
- Enhance `technical-debt-assessor` for debt identification and prioritization
- Separate security and quality concerns for better focus and expertise
- Maintain quality reporting in dedicated quality section with specialized agents