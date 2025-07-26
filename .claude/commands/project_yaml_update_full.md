# Project YAML Update

Update the project YAML file with current project state and structure using specialized analysis agents.

## Description
This command orchestrates specialized agents to systematically update the `_project/_project.yml` file to accurately reflect the current project structure, dependencies, and configuration. It leverages parallel agent execution for comprehensive analysis and coordinated documentation synchronization.

## Usage
`project_yaml_update [section]`

## Variables
- PROJECT_ROOT: Starting directory for analysis (default: current directory)
- YAML_PATH: Path to project YAML file (default: _project/_project.yml)
- SECTION: Specific section to update (default: all sections)
- BACKUP: Create backup before updating (default: true)

## Agent Execution Strategy

### Phase 1: Parallel Analysis (Independent Agents)
Execute these agents concurrently for comprehensive project analysis:

1. **Project Structure Analyzer**: Maps directory organization, file relationships, and architectural patterns
2. **Context7 Library Mapper**: Identifies dependencies and resolves Context7 documentation IDs  
3. **Business Context Extractor**: Maps technical implementation to business requirements and project goals
4. **Technical Debt Assessor**: Identifies current goals and improvement priorities

### Phase 2: YAML Creation/Update (Dependent Agent)
5. **Project YAML Manager**: Integrates findings from Phase 1 agents to create/update `_project.yml` with:
   - Current project structure using semantic compression principles
   - Technology stack with Context7 documentation references
   - Business context, purpose, and goals alignment
   - Component implementation phases and status
   - Performance metrics and architectural patterns
   - Proper YAML formatting following embedded specification standards

## Agent Integration Flow
- **Structure Analysis** → Directory organization and component mapping for YAML
- **Library Mapping** → Technology stack section with Context7 references
- **Business Context** → Purpose, goals, and business value sections
- **Technical Debt Assessment** → Current goals and improvement priorities
- **YAML Management** → Semantically compressed YAML file creation with embedded specifications

## Examples

### Example 1: Full project update
Complete refresh of project YAML after major structural changes or milestone completion.

### Example 2: Directory structure sync
Update just the directories section after reorganizing project files.

### Example 3: Metadata refresh
Update project metadata after version release or status change.

## Integration Points
- **Specification Compliance**: The project-yaml-manager agent has embedded YAML specification standards for consistent formatting and semantic compression
- **Agent Dependencies**: Leverages outputs from structure, library, business context, and technical debt analysis agents
- **Version Control**: Consider committing YAML updates as documentation improvements

## Best Practices
- Always backup existing YAML before major updates
- Compare documented vs actual structure systematically
- Update descriptions to be accurate and helpful
- Maintain consistency with established naming conventions
- Validate YAML syntax after updates
- Consider impact on other team members relying on the documentation

## Notes
- Focus on accuracy over completeness - better to have correct partial documentation
- Pay attention to both explicit file structure and implicit project organization
- Update status to reflect actual project state, not aspirational goals
- Consider both technical structure and business context when updating purpose/goals