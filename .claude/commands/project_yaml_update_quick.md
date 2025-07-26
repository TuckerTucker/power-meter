# Project YAML Update Quick

Rapidly update _project.yml using Context Prime approach and semantic compression principles.

## Description
This command quickly updates your project's YAML documentation by leveraging existing context sources and the project-yaml-manager agent. It applies semantic compression principles to maintain optimal AI readability while ensuring all critical information is preserved. Updates complete in under 2 minutes without running full analysis.

## Usage
`project_yaml_update_quick [focus_area]`

## Variables
- PROJECT_ROOT: Project directory containing _project.yml (default: current directory)
- UPDATE_MODE: "quick" (core updates) or "comprehensive" (full review) (default: quick)
- BACKUP: Create backup before updating (default: true)

## Update Strategy
- Load existing context using Context Prime approach
- Apply project-yaml-manager agent for semantic compression
- Focus on current state and active development
- Preserve quantitative metrics and version information

## Context Sources (Loaded in Parallel)

### Phase 1: Current State Assessment
1. **Existing Project YAML** (`_project/_project.yml`):
   - Current structure and configuration
   - Technology stack and versions
   - Development priorities and goals

2. **Project Structure**:
   - Directory organization via LS/Glob
   - Recent file additions or changes
   - Component relationships

3. **Recent Changes**:
   - Git status and recent commits
   - Modified files and new features
   - Configuration updates

### Phase 2: Enhancement Sources
4. **Package Dependencies**:
   - package.json for version updates
   - New libraries or framework changes
   - Context7 reference mappings

5. **Recent Reports** (if available):
   - Latest analysis findings
   - Technical debt updates
   - Performance metrics

6. **Configuration Files**:
   - .claude/settings.local.json
   - Build configuration changes
   - Environment updates

## Semantic Compression Applied
- **Pattern Consolidation**: Group similar files with wildcards
- **Phase-Based Organization**: Current > Important > Reference
- **Quantitative Preservation**: Keep all metrics and versions
- **Active Focus**: Prioritize current development over history
- **Hierarchy Maintenance**: Preserve semantic relationships

## Examples
### Example 1: Quick structure update
Update YAML after adding new components or directories in 30 seconds.

### Example 2: Post-feature update  
Refresh YAML after implementing new features to reflect current state.

### Example 3: Version bump
Update technology stack versions after dependency updates.

## Benefits
- **Sub-2-minute updates** - typically 30-90 seconds
- **Context Prime efficiency** - leverages existing knowledge
- **Semantic compression** - maintains AI readability
- **Current state focus** - reflects actual implementation
- **Minimal overhead** - no full analysis required

## Notes
- Uses project-yaml-manager agent for consistent formatting
- Creates timestamped backup before updates
- Validates YAML syntax before saving
- Preserves custom sections not in standard template
- Run `repo_review` for comprehensive analysis if needed