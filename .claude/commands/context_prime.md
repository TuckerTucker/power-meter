# Context Prime

Rapidly establish project context by loading existing documentation and analysis reports.

## Description
This command quickly primes the AI with comprehensive project understanding by reading pre-existing documentation, analysis reports, and project metadata. It provides near-instant context loading (< 1 minute) without running any analysis, ensuring you can start productive work immediately.

## Usage
`context_prime [focus_area]`

## Variables
- PROJECT_ROOT: Project directory containing artifacts (default: current directory)
- CONTEXT_LEVEL: Loading depth - "quick" (core only) or "full" (all sources) (default: full)
- CACHE: Use cached context if available (default: true)

## Directory Exclusions
**Important**: When loading project context, exclude analysis artifacts and agent configurations:
- Skip `.claude/` directory (agent configurations and command definitions)
- Skip `_project/` directory (analysis outputs and project metadata)
- Focus on actual source code and documentation for context building

## Context Loading Strategy
- Read existing project documentation and reports in parallel
- Execute all three phases when CONTEXT_LEVEL="full" (default)
- Execute only Phase 1 when CONTEXT_LEVEL="quick"
- Prioritize most recent and comprehensive sources
- Focus on actionable context for immediate productivity
- No analysis execution - only reading existing artifacts
- Skip missing files gracefully and continue loading
- **Always use directory ignore patterns**: `[".claude", "_project"]` when reading project structure

## Context Sources (Priority Order)

**Execution Logic:**
- Phase 1: Always executed (core context)
- Phase 2: Executed when CONTEXT_LEVEL="full" (default)
- Phase 3: Executed when CONTEXT_LEVEL="full" (default)
- All files are loaded in parallel within each phase
- Missing files are skipped without stopping execution

### Phase 1: Core Project Context (Always Loaded)
1. **Project YAML** (`_project/_project.yml`):
   - Project metadata, structure, and purpose
   - Technology stack with Context7 references
   - Current development phase and priorities

2. **Claude Configuration** (`_project/_claude/claude.local.md`):
   - Project-specific AI instructions
   - Coding conventions and standards
   - Key architectural decisions

3. **README Files**:
   - Main `README.md` for project overview
   - Component-specific READMEs for subsystems
   - Setup and development instructions

### Phase 2: Recent Analysis Reports (Loaded when CONTEXT_LEVEL="full")
4. **Repository Review Reports**:
   - `_project/repo-review/reports/consolidated/executive-summary.md`
   - `_project/repo-review/reports/consolidated/full-report.md`
   - Latest findings on security, quality, and technical debt

5. **Knowledge Graph Snapshot**:
   - `_project/mcp-knowledge-graph/memory/knowledge-graph.jsonl`
   - Entity relationships and observations
   - Recent project insights and patterns

6. **Agent Analysis Outputs**:
   - Recent outputs in `_project/repo-review/reports/agents/*/`
   - Structured findings and recommendations
   - Technical debt inventory

### Phase 3: Supplementary Context (Loaded when CONTEXT_LEVEL="full")
7. **Documentation Artifacts**:
   - `_project/_ref/` reference materials
   - `_project/_specs/` planning documents

8. **Recent Git Context**:
   - Last 10 commit messages for recent changes
   - Current branch and merge status
   - Modified files in working directory

## Examples
### Example 1: Fresh session start
Load all available context sources for comprehensive understanding.

### Example 2: Quick context refresh
Load only core sources (YAML + README + recent reports)

### Example 3: Post-analysis context
Prime with latest repo review reports.

## Implementation Notes

### Phase Execution
- **CONTEXT_LEVEL="full"** (default): Executes all three phases sequentially
- **CONTEXT_LEVEL="quick"**: Executes only Phase 1 for rapid context loading
- Each phase loads files in parallel for optimal performance
- Phases continue even if individual files are missing

### Error Handling
- Missing files are skipped silently without stopping execution
- Each phase completes independently
- A summary shows which context sources were successfully loaded
- If critical files are missing (e.g., project YAML), suggest running setup commands

### Usage Guidelines
- If reports don't exist, suggest running `repo_review` or `project_yaml_update` to create the documents
- Parallel file reading ensures rapid context acquisition (< 1 minute for full load)
- Skip missing files gracefully - not all projects have all artifacts
- Focus on most recent and relevant information
- Consider setting CONTEXT_LEVEL="quick" for routine operations