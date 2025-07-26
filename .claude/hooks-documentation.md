# TKR Project Kit - Claude Code Hooks Documentation

## Overview
This document describes the pretool hook system set up for the TKR Project Kit to ensure the MCP Knowledge Graph server is running before knowledge graph operations.

## Hook Configuration

### Files Created:
- `.claude/hooks.sh` - Main hook script
- Updated `.claude/settings.local.json` - Hook configuration

### Hook Features:
1. **Auto-detection** of knowledge graph operations
2. **Automatic server startup** when needed
3. **Build verification** before server start
4. **Process monitoring** and PID management
5. **Logging** to `/tmp/mcp-knowledge-graph.log`

## Supported Operations

The hook automatically activates for:

### MCP Tools:
- `create_entities` - Add new project entities
- `create_relations` - Create relationships between entities  
- `add_observations` - Record insights and notes
- `delete_entities` - Remove outdated entities
- `delete_relations` - Clean up relationships
- `delete_observations` - Remove obsolete observations
- `search_nodes` - Query the knowledge graph
- `read_graph` - Read graph structure

### Task Agent:
- Any Task using `knowledge-graph-manager` subagent

## Hook Behavior

When a knowledge graph operation is detected:

1. **Check if server running**: Uses `pgrep -f "mcp-knowledge-graph"`
2. **Build if needed**: Runs `npm run build` in MCP directory
3. **Start server**: Launches `node dist/index.js` in background
4. **Verify startup**: Confirms process started successfully
5. **Log activity**: Records server status and PID

## Manual Operations

### Start Server Manually:
```bash
cd _project/mcp-knowledge-graph
npm run build
node dist/index.js
```

### Check Server Status:
```bash
pgrep -f "mcp-knowledge-graph"
```

### View Server Logs:
```bash
tail -f /tmp/mcp-knowledge-graph.log
```

### Stop Server:
```bash
pkill -f "mcp-knowledge-graph"
```

## Permissions Added

The following permissions were added to `.claude/settings.local.json`:

```json
{
  "hooks": {
    "pretool": ".claude/hooks.sh"
  },
  "permissions": {
    "allow": [
      "Bash(node:*)",
      "Bash(nohup:*)", 
      "Bash(pgrep:*)",
      "Bash(kill:*)",
      "Bash(sleep:*)",
      "create_entities",
      "create_relations",
      "add_observations", 
      "delete_entities",
      "delete_relations",
      "delete_observations",
      "search_nodes",
      "read_graph"
    ]
  }
}
```

## Testing

### Test Hook Activation:
```bash
# This should trigger the hook
/knowledge_graph_update
```

### Verify Hook Function:
The hook should display:
- `🧠 Knowledge graph operation detected`
- `🚀 Starting MCP Knowledge Graph server...` (if not running)
- `✅ MCP Knowledge Graph server started successfully`

## Troubleshooting

### Hook Not Running:
1. Verify `.claude/hooks.sh` is executable: `chmod +x .claude/hooks.sh`
2. Check settings.local.json has correct hook configuration
3. Ensure all required permissions are granted

### Server Won't Start:
1. Check if dependencies are installed: `cd _project/mcp-knowledge-graph && npm install`
2. Verify build works: `npm run build`
3. Check for port conflicts or permission issues
4. Review logs at `/tmp/mcp-knowledge-graph.log`

### MCP Tools Not Available:
1. Verify the MCP server is properly registered with Claude Code
2. Check Claude Code's MCP configuration
3. Ensure the server is responding on the correct protocol

## Integration Benefits

This hook system provides:
- **Seamless Experience**: No manual server management required
- **Automatic Recovery**: Server restarts if needed
- **Development Efficiency**: Focus on knowledge graph operations, not infrastructure
- **Error Prevention**: Catches missing server scenarios early
- **Logging**: Full audit trail of server operations

## Future Enhancements

Potential improvements:
- Health checks and automatic restart on failure
- Configuration validation before server start
- Integration with Claude Code's native MCP management
- Multiple server environment support
- Performance monitoring and metrics collection