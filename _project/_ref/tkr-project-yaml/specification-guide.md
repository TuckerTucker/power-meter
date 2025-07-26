# YAML Design Documentation Specification Guide
## Compressed-First Documentation for AI Agents

This guide provides instructions for creating semantically compressed YAML documentation that preserves all essential information while maintaining readability for AI coding agents.

## Core Principles

### Compression-First Mindset
Write documentation using these priority levels from the start:

**CRITICAL (Always detailed):**
- Current development goals and active tasks
- Architecture decisions and patterns
- Technology stack with versions
- Performance metrics and benchmarks
- Active component implementation status

**IMPORTANT (Summarized):**
- Directory structures and organization
- Component relationships and hierarchies
- Configuration patterns
- Recently completed features

**REFERENCE (Heavily compressed):**
- Historical achievements
- Future aspirations beyond current cycle
- Detailed specifications for standard patterns
- Verbose explanations of obvious functionality

### Information Architecture Rules
1. **Pattern-based over individual documentation**
2. **Phase-based grouping over exhaustive lists**
3. **Wildcard consolidation for similar items**
4. **Quantitative data preservation**
5. **Semantic hierarchy maintenance**

## Core Project YAML Structure

### Project Metadata (Always Minimal)
```yaml
project:
  name: "Project Name"
  version: "1.0.0"
  description: "Concise project purpose in one sentence"
  author: "Team Name"
  timestamp: "2025-07-22"
  status: "production-ready|in-progress|planning"
```

**Compression Rules:**
- Description: Single sentence, no marketing language
- Role field: Remove unless adds semantic value
- Timestamp: Update only on significant architecture changes

### Directory Structure (Pattern-Based)
```yaml
directories:
  - path: "src/components/"
    subdirectories:
      - path: "layout/"
        files:
          - "*.tsx": "Layout container components"
          - "*.stories.tsx": "Storybook documentation"
      - path: "ui/"
        files:
          - "Button.tsx": "Primary interactive component"
          - "*.tsx": "Base UI components"
    files:
      - "App.tsx": "Main application entry point"
```

**Compression Techniques:**
- Use wildcards for 3+ similar files
- Flatten unnecessary directory nesting
- Group by functional purpose, not file type
- Document only development-critical paths

### Technology Stack (Concise Versioning)
```yaml
technology:
  runtime:
    node: ">=18.0.0"
    browsers: "Modern browsers with ES2020 support"
  
  backend:
    framework: "Express ^4.21.2"
    database: "better-sqlite3 ^8.7.0"
    language: "TypeScript ^5.8.3"
    apis:
      - "Provider API (package ^version)"
    
  frontend:
    framework: "React ^18.3.1"
    build_tool: "Vite ^5.4.19"
    language: "TypeScript ^5.8.3"
    component_development: "Storybook ^9.0.17"
    
  development:
    monorepo: "npm workspaces"
    linting: "ESLint"
```

**Compression Rules:**
- Include only major dependencies with versions
- Group by architectural layer
- Remove obvious or implied dependencies
- Preserve exact versions for critical packages

### Purpose and Goals (Status-Focused)
```yaml
purpose:
  summary: "Single sentence describing core functionality"
  
  completed_features:
    - "Major architectural achievements"
    - "Performance improvements with metrics"
    - "Significant integrations completed"

  current_goals:
    - "Active development priorities"
    - "Current phase objectives"
    - "Immediate technical debt"
```

**Compression Rules:**
- Completed features: Only major milestones, not minor features
- Current goals: 5-7 maximum, focused on current development phase
- Remove future goals beyond next development cycle

### Architecture (Pattern-Focused)
```yaml
architecture:
  core_patterns:
    - "Primary architectural pattern (e.g., SSE streaming)"
    - "Key performance optimizations"
    - "Integration approach"
  
  ui_architecture:
    layout: "Layout pattern description"
    sections: ["Section1", "Section2", "Section3"]
    interaction_patterns: "Primary interaction model"
    responsive: "Responsive strategy summary"
```

**Compression Rules:**
- Document patterns, not implementations
- Include only architecture-defining decisions
- Remove obvious or standard patterns
- Focus on what makes this project unique

### Component Implementation (Phase-Based)
```yaml
ui_components:
  component_completeness: "X% (current/total components)"
  
  implementation_phases:
    phase_1_foundation:
      priority: "high"
      components: ["CoreComponent1", "CoreComponent2"]
      status: "in_progress|completed|planned"
    
    phase_2_features:
      priority: "medium"
      components: ["FeatureComponent1", "FeatureComponent2"]
      status: "planned"
    
    phase_3_advanced:
      priority: "lower"
      components: ["AdvancedComponent1"]
      status: "future"
```

**Compression Rules:**
- Group components by development phase, not by type
- Include only component names, not detailed specifications
- Preserve quantitative progress tracking
- Status reflects actual development state

### Performance Metrics (Quantitative Data)
```yaml
performance:
  key_metrics:
    primary_operation: "X seconds for Y operation"
    improvement: "Nx faster than baseline"
  targets:
    response_time: "< X seconds"
    throughput: "Y operations/second"
```

**Compression Rules:**
- Include only measurable, significant metrics
- Preserve comparative data (improvements, benchmarks)
- Remove aspirational or unmeasured targets

## Component YAML (When Individual Documentation Needed)

### Compressed Component Template
```yaml
component:
  name: "component_name"
  purpose: "Single sentence describing function"
  category: "layout|ui|feature|integration"
  status: "complete|in-progress|planned"
  
implementation:
  props: ["prop1", "prop2", "prop3"]
  states: ["state1", "state2"]
  dependencies: ["Component1", "Component2"]
  
patterns:
  interaction: "standard|custom"
  responsive: "mobile-first|desktop-first|adaptive"
  accessibility: "WCAG 2.1 AA compliant"
```

**When to Create Individual Component YAML:**
- Complex components with unique patterns
- Components requiring detailed state documentation
- Integration components with external dependencies
- Components with custom accessibility requirements

**When to Skip Individual Documentation:**
- Standard UI components following established patterns
- Simple layout containers
- Components already well-documented in phase groupings
- Utility or helper components

## Advanced Patterns

### Pattern Inheritance
```yaml
base_patterns:
  crud_interface:
    flow: "create → list → select → edit → delete"
    layout: "action_bar + item_list + detail_pane"
    interactions: "auto_save + validation + feedback"

section_implementations:
  templates:
    base: crud_interface
    variations: ["hero_management", "plot_editing"]
  stories:
    base: crud_interface
    variations: ["provider_selection", "streaming_progress"]
```

### Wildcard Documentation
```yaml
# Instead of listing every similar file
files:
  - "Component1.stories.tsx": "Storybook stories for Component1"
  - "Component2.stories.tsx": "Storybook stories for Component2"
  - "Component3.stories.tsx": "Storybook stories for Component3"

# Use patterns
files:
  - "*.stories.tsx": "Storybook component documentation"
  - "Button.tsx": "Primary interactive component"
  - "*.tsx": "UI components following design system"
```

### Information Layering
```yaml
# Layer 1: Essential architecture (always included)
architecture:
  streaming_architecture: "Real-time SSE communication"
  ui_architecture: "Two-column responsive layout"

# Layer 2: Implementation details (include if active development)
current_implementation:
  component_status: "Phase 1: 60% complete"
  active_patterns: ["auto_save", "real_time_updates"]

# Layer 3: Reference information (compress heavily or omit)
# historical_context: (removed in compressed version)
# detailed_specifications: (moved to separate files if needed)
```

## Quality Assurance

### Compression Validation Checklist
- [ ] File size 70-85% smaller than verbose version
- [ ] All quantitative metrics preserved
- [ ] Current development information intact
- [ ] Architecture decisions documented
- [ ] Technology versions specified
- [ ] Navigation paths maintained
- [ ] No duplicate YAML keys
- [ ] Semantic meaning preserved for AI agents

### Common Anti-Patterns to Avoid
1. **Individual documentation of standard components**
2. **Verbose descriptions of obvious functionality**
3. **Historical information taking precedence over current needs**
4. **Repetitive directory structure documentation**
5. **Over-specification of completed features**
6. **Missing wildcard consolidation opportunities**

### Target Metrics
- **Overall reduction**: 75-85% from verbose equivalent
- **Information density**: High semantic value per line
- **Navigation utility**: Essential paths preserved
- **Development relevance**: Focused on current/next phase work

## Implementation Guidelines

### Starting a New Project
1. **Begin with patterns, not individual components**
2. **Use phase-based component organization from start**
3. **Apply wildcards for repetitive file types**
4. **Document architecture decisions, not implementations**
5. **Preserve quantitative data, compress qualitative descriptions**
6. **Focus on current development cycle, not entire project lifecycle**

### Maintaining Documentation
- Update component completeness percentages regularly
- Move completed phases to compressed historical summary
- Keep technology versions current
- Review and compress growing sections quarterly
- Maintain focus on active development priorities

This specification guide ensures your YAML documentation starts compressed and stays semantically dense while preserving all information needed for effective AI-assisted development.