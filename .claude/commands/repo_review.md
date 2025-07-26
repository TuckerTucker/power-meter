# Repository Review

Execute comprehensive parallel repository analysis using specialized AI agents and consolidate findings into unified reports.

## Description
This command performs a complete repository analysis workflow by running specialized AI agents in parallel, then automatically consolidating their findings into executive summaries and comprehensive reports. It combines the parallel execution and merge phases into a single streamlined operation.

## Usage
`repo_review [target_repo] [agents]`

## Variables
- REPO_PATH: Repository to analyze (default: current directory)
- TARGET_REPO: Specific target path (default: ${REPO_PATH})
- MAX_DEPTH: Analysis depth limit (default: 3)
- AGENTS: Comma-separated agent list (default: "project-structure-analyzer,vulnerability-scanner,secrets-detector,input-validation-scanner,auth-security-analyzer,cryptographic-security-auditor,error-handling-analyzer,dependency-security-scanner,dependency-lifecycle-manager,container-security-auditor,accessibility-security-auditor,api-security-analyzer,mobile-security-scanner,code-quality-analyzer,technical-debt-assessor")
- OUTPUT_FORMAT: Report format (default: "markdown+json")

## Agent Execution Strategy
- Execute specialized analysis agents concurrently for maximum efficiency
- Use report-consolidator agent for final consolidation phase
- Leverage new agent system in `.claude/agents/` for enhanced capabilities

## Steps

### Phase 1: Setup and Configuration
1. **Create Analysis Configuration**:
   - Generate shared config at `${REPO_PATH}/_project/repo-review/reports/analysis.config.json`
   - Set analysis date, output format, and selected agents
   - Initialize directory structure for reports

### Phase 2: Parallel Analysis Execution

2. **Execute Agents in Parallel Tiers**:

   **Tier 1 - Fast Pattern-Based Agents (Execute First - 30-60 seconds)**:
   ```bash
   # Run simultaneously for immediate results
   /vulnerability-scanner "Scan for attack vectors and injection vulnerabilities" &
   /secrets-detector "Detect exposed credentials and API keys" &  
   /input-validation-scanner "Analyze data sanitization and validation" &
   wait  # Wait for Tier 1 completion
   ```

   **Tier 2 - Logic Analysis Agents (After Tier 1 - 2-4 minutes)**:
   ```bash
   # Run simultaneously after Tier 1 completes
   /auth-security-analyzer "Analyze authentication and authorization mechanisms" &
   /cryptographic-security-auditor "Audit cryptographic implementations" &
   /error-handling-analyzer "Review error handling and information disclosure" &
   wait  # Wait for Tier 2 completion
   ```

   **Tier 3 - External Dependency Agents (Parallel with Tier 2 - 3-6 minutes)**:
   ```bash
   # Run simultaneously (can start after Tier 1)
   /dependency-security-scanner "Scan for CVE vulnerabilities in dependencies" &
   /dependency-lifecycle-manager "Analyze dependency health and optimization" &
   /container-security-auditor "Audit container and infrastructure security" &
   wait  # Wait for Tier 3 completion
   ```

   **Tier 4 - Specialized Domain Agents (After Tier 2 - 2-5 minutes)**:
   ```bash
   # Run simultaneously after logic analysis
   /accessibility-security-auditor "Audit WCAG compliance and accessibility security" &
   /api-security-analyzer "Analyze REST/GraphQL API endpoint security" &
   /mobile-security-scanner "Scan mobile platform-specific security" &
   wait  # Wait for Tier 4 completion
   ```

   **Quality Analysis Agents (Parallel with Security - 3-5 minutes)**:
   ```bash
   # Run simultaneously with security tiers
   /code-quality-analyzer "Analyze code quality, testing, and documentation" &
   /technical-debt-assessor "Identify and prioritize technical debt" &
   wait  # Wait for Quality analysis completion
   ```

   **Foundation Agents (Runs First)**:
   ```bash
   # Execute early for architectural context
   /project-structure-analyzer "Map directory organization and architectural patterns"
   ```
   
   Each agent produces:
   - **Dashboard-compatible outputs** in category-specific directories
   - **Structured JSON findings** for interactive visualization
   - **Comprehensive markdown reports** for detailed analysis
   - **Metrics JSON** for quantitative dashboard display

3. **Monitor Execution Progress**:
   - Track completion status of each parallel task
   - Log execution timestamps and metrics
   - Ensure all agents complete before proceeding

### Phase 3: Consolidation and Reporting
4. **Execute Consolidation Agents**:
   - **security-report-consolidator**: Aggregate all security findings into unified security reports
   - **quality-report-consolidator**: Consolidate quality and technical debt findings
   - Generate executive summaries with key metrics and priorities
   - Create comprehensive consolidated reports with cross-references
   - Build unified dashboard outputs for interactive visualization
   - Produce prioritized remediation roadmaps and action plans

## Output Structure
```
${REPO_PATH}/_project/repo-review/reports/
├── analysis.config.json                 # Analysis configuration
├── execution-metrics.json              # Execution tracking
├── dashboard.html                       # Interactive dashboard
├── server.js                           # Local web server
├── favicon.ico                         # Dashboard favicon
├── merged-analysis.md                  # Executive analysis report
├── merged-findings.json                # Dashboard-compatible summary
├── security/                           # Consolidated security analysis
│   ├── consolidated-findings.json     # Unified security findings
│   ├── executive-summary.md           # Security posture summary
│   ├── detailed-report.md             # Comprehensive security analysis
│   ├── remediation-roadmap.md         # Prioritized security action plan
│   ├── vulnerability-findings.json    # Attack vector analysis
│   ├── secrets-findings.json          # Credential exposure analysis
│   ├── auth-findings.json             # Authentication security
│   ├── cryp-sec-findings.json           # Cryptographic security
│   ├── dependency-findings.json       # Security vulnerabilities
│   ├── api-findings.json              # API security analysis
│   ├── accessibility-findings.json    # Accessibility security
│   ├── container-findings.json        # Infrastructure security
│   ├── mobile-findings.json           # Mobile security
│   ├── error-handling-findings.json   # Information disclosure
│   └── input-validation-findings.json # Data sanitization
├── dependencies/                       # Dependency lifecycle management
│   ├── lifecycle-analysis.json        # Comprehensive dependency health
│   ├── dependency-risk-matrix.json    # Risk assessment
│   ├── update-priority-list.json      # Update recommendations
│   ├── license-compliance-report.json # License analysis
│   ├── bundle-optimization.json       # Performance optimization
│   └── alternative-packages.json      # Package alternatives
├── quality/                            # Code quality and technical debt
│   ├── quality-consolidated.json      # Unified quality findings
│   ├── quality-executive-summary.md   # Quality posture summary
│   ├── improvement-roadmap.md         # Quality improvement plan
│   ├── technical-debt-matrix.md       # Debt prioritization
│   ├── code-analysis.json             # Code quality metrics
│   ├── technical-debt.json            # Technical debt inventory
│   ├── testing-strategy.json          # Test coverage analysis
│   ├── documentation-gaps.json        # Documentation assessment
│   └── refactoring-roadmap.json       # Refactoring recommendations
├── overview/                           # Architecture & business overview
│   ├── analysis-report.md             # Detailed overview report
│   ├── findings.json                  # Structured overview findings
│   └── metrics.json                   # Overview metrics
└── index.md                           # Navigation hub
```

## Examples

### Example 1: Full analysis
```bash
repo_review /path/to/repo
```
Runs all default agents across 4 tiers with complete consolidation and unified reporting.

### Example 2: Security-focused review
```bash
repo_review /path/to/repo "vulnerability-scanner,secrets-detector,auth-security-analyzer,dependency-security-scanner"
```
Runs core security analyses with targeted security reporting.

### Example 3: Quality-focused review
```bash
repo_review /path/to/repo "code-quality-analyzer,technical-debt-assessor"
```
Focuses on code quality and technical debt analysis with improvement roadmaps.

### Example 4: Deep analysis
```bash
MAX_DEPTH=5 repo_review /path/to/repo
```
Performs comprehensive deep analysis with extended file traversal.

## Integration Points
- **New Agent System**: Uses enhanced agents from `.claude/agents/` directory
- **Knowledge Graph**: Integrates with knowledge-graph-manager agent for persistent memory
- **Project YAML**: Works with project-yaml-manager for documentation updates
- **Context7 Integration**: Leverages context7-library-mapper for dependency documentation

## Workflow Optimization
- **Parallel Execution**: All agents run simultaneously for speed
- **Incremental Processing**: Only rerun agents if source changes detected
- **Smart Caching**: Reuse analysis data when possible
- **Progress Tracking**: Real-time status updates during execution

## Quality Assurance
- **Validation Checks**: Verify all expected outputs are generated
- **Error Handling**: Graceful degradation if individual agents fail
- **Consistency**: Standardized output formats across all agents
- **Completeness**: Ensure no critical findings are lost in aggregation

## Best Practices
- Run after significant code changes or before releases
- Review executive summary first, then dive into specific agent reports
- Use findings to prioritize development tasks and technical debt
- Archive reports for historical comparison and trend analysis
- Integrate findings into development workflow and planning

## Notes
- All agents work on the same repository without creating copies
- Execution time scales with repository size and selected agents
- JSON outputs enable programmatic integration with other tools
- Markdown reports provide human-readable analysis and recommendations
- Configuration allows customization for different project types and needs