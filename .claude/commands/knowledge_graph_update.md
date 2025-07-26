# Knowledge Graph Update

Update the local knowledge graph using the MCP server to capture current project state and insights.

## Description
This command uses the knowledge-graph-manager agent to systematically update the MCP knowledge graph, capturing project entities, relationships, and insights for persistent AI memory. It ensures the knowledge graph stays synchronized with project evolution through comprehensive analysis and structured data modeling.

## Usage
`knowledge_graph_update [focus_area]`

## Variables
- PROJECT_ROOT: Starting directory for analysis (default: current directory)
- MEMORY_PATH: Path to knowledge graph storage (default: _project/mcp-knowledge-graph/memory)
- FOCUS_AREA: Specific domain to update (default: comprehensive update)
- BACKUP: Create backup before updating (default: true)

## Agent Execution Strategy
- Use the specialized **knowledge-graph-manager** agent for MCP integration
- Leverage parallel analysis agents to gather comprehensive project insights
- Execute systematic knowledge graph updates through the MCP protocol

## Execution Phases

### Phase 1: Project Analysis (Parallel Agents)
Execute these agents concurrently to gather comprehensive project insights:

1. **project-structure-analyzer**: Extract architectural entities and component relationships
2. **business-context-extractor**: Capture business requirements and feature mappings
3. **technical-debt-assessor**: Identify improvement opportunities and development insights
4. **security-quality-scanner**: Document security patterns and quality observations
5. **context7-library-mapper**: Map external dependencies with documentation references

### Phase 2: Knowledge Graph Update (Sequential)
Use the **knowledge-graph-manager** agent to:

1. **Process Analysis Results**:
   - Convert findings into knowledge graph entities
   - Create relationships between identified components
   - Add observations from technical and business analysis

2. **Update Graph Structure**:
   - Create new entities for discovered components
   - Establish relationships based on dependencies
   - Add observations capturing key insights
   - Remove outdated or invalid entries

3. **Validate and Optimize**:
   - Ensure referential integrity
   - Clean up orphaned entities
   - Optimize graph structure for query performance

## MCP Operations Used
- `create_entities`: Add new project components and concepts
- `create_relations`: Map relationships between components
- `add_observations`: Record insights and technical details
- `delete_entities`: Remove outdated components
- `delete_relations`: Clean up broken relationships
- `delete_observations`: Remove obsolete information
- `search_nodes`: Find existing relevant entities
- `read_graph`: Validate current graph state

## Examples

### Example 1: Full project analysis
Complete knowledge graph update using all analysis agents after major changes.

### Example 2: Security and quality focused update
Update graph using security-quality-scanner findings after security review.

### Example 3: Technical debt and architecture update
Focused update using structure analyzer and debt assessor after refactoring.

### Example 4: Business context synchronization
Update graph with business-context-extractor findings after requirements change.

## Integration Points
- **MCP Server**: Integrates with local MCP knowledge graph server via knowledge-graph-manager agent
- **Analysis Agents**: Leverages all specialized agents for comprehensive project analysis
- **Project YAML**: Complements project-yaml-manager updates with relational context
- **Repository Review**: Can process findings from repo_review command
- **Context7**: Uses library mapper for dependency documentation integration

## Best Practices
- Always backup knowledge graph before major updates
- Use specific, descriptive entity names and types
- Create meaningful relationships that capture actual dependencies
- Write observations that provide actionable insights
- Maintain consistent entity typing and naming conventions
- Validate relationships for accuracy and relevance
- Focus on capturing knowledge that persists across sessions

## Entity Types to Consider
- `software_component`: Major modules, services, libraries
- `technical_concept`: Patterns, architectures, algorithms  
- `business_requirement`: Features, user stories, objectives
- `technical_debt`: Issues, improvements, refactoring needs
- `configuration`: Settings, environment variables, deployment configs
- `external_dependency`: Third-party libraries, services, APIs
- `development_process`: Workflows, practices, standards

## Relation Types to Consider
- `depends_on`: Component dependencies
- `implements`: Feature implementations
- `extends`: Inheritance relationships
- `configures`: Configuration relationships
- `tests`: Testing relationships
- `deploys_to`: Deployment relationships
- `addresses`: Problem-solution mappings

## Notes
- Focus on capturing relationships and insights that are valuable across development sessions
- Balance between comprehensive coverage and actionable specificity
- Update observations to reflect current state, not historical artifacts
- Consider both technical architecture and business context when modeling entities
- Use the knowledge graph to enhance AI understanding for future development tasks
- Leverage visualization capabilities to validate graph structure and relationships