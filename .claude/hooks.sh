#!/bin/bash

# TKR Project Kit - Claude Code Hooks
# Ensures the TKR Project Kit MCP Knowledge Graph server is running before using knowledge graph tools
# This is SPECIFIC to /Volumes/tkr-riffic/@tkr-projects/tkr-project-kit/_project/mcp-knowledge-graph

# Configuration for our specific MCP server
readonly TKR_PROJECT_ROOT=$CLAUDE_PROJECT_DIR
readonly TKR_MCP_DIR="$TKR_PROJECT_ROOT/_project/mcp-knowledge-graph"
readonly TKR_MCP_LOG="/tmp/tkr-mcp-knowledge-graph.log"
readonly TKR_MCP_PID="/tmp/tkr-mcp-knowledge-graph.pid"

# Check if OUR specific TKR Project Kit MCP server is running
is_tkr_mcp_server_running() {
    # Method 1: Check by exact path to our server
    if pgrep -f "$TKR_MCP_DIR/dist/index.js" > /dev/null; then
        return 0
    fi
    
    # Method 2: Check by PID file if it exists
    if [ -f "$TKR_MCP_PID" ]; then
        local stored_pid=$(cat "$TKR_MCP_PID" 2>/dev/null)
        if [ -n "$stored_pid" ] && kill -0 "$stored_pid" 2>/dev/null; then
            # Verify it's actually our server by checking the command
            if ps -p "$stored_pid" -o command= | grep -q "$TKR_MCP_DIR/dist/index.js"; then
                return 0
            fi
        fi
    fi
    
    return 1
}

# Check if this is a knowledge graph related tool call
check_knowledge_graph_tool() {
    local tool_name="$1"
    local tool_args="$2"
    
    # Check for knowledge graph MCP tools that should be available
    case "$tool_name" in
        "create_entities"|"create_relations"|"add_observations"|"delete_entities"|"delete_relations"|"delete_observations"|"search_nodes"|"read_graph")
            return 0  # This is a knowledge graph tool
            ;;
        "Task")
            # Check if the task involves knowledge-graph-manager agent
            if echo "$tool_args" | grep -q "knowledge-graph-manager"; then
                return 0  # This task uses the knowledge graph manager
            fi
            ;;
    esac
    return 1  # Not a knowledge graph tool
}

# Start the TKR Project Kit MCP Knowledge Graph server if not running
start_tkr_mcp_server() {
    # Check if OUR specific TKR Project Kit MCP server is already running
    if is_tkr_mcp_server_running; then
        echo "✅ TKR Project Kit MCP Knowledge Graph server is already running"
        return 0
    fi
    
    echo "🚀 Starting MCP Knowledge Graph server..."
    
    # Ensure the TKR Project Kit server is built
    if [ ! -f "$TKR_MCP_DIR/dist/index.js" ]; then
        echo "📦 Building TKR Project Kit MCP Knowledge Graph server..."
        cd "$TKR_MCP_DIR" && npm run build
        if [ $? -ne 0 ]; then
            echo "❌ Failed to build TKR Project Kit MCP server"
            return 1
        fi
    fi
    
    # Start OUR specific TKR Project Kit knowledge graph server
    cd "$TKR_MCP_DIR"
    
    # Start the server with a clear identifier
    nohup node dist/index.js --server-name="tkr-project-kit-knowledge-graph" > "$TKR_MCP_LOG" 2>&1 &
    local server_pid=$!
    
    # Store PID immediately
    echo $server_pid > "$TKR_MCP_PID"
    
    # Wait a moment for the server to start
    sleep 3
    
    # Verify the server started successfully
    if kill -0 $server_pid 2>/dev/null; then
        echo "✅ TKR Project Kit MCP Knowledge Graph server started successfully (PID: $server_pid)"
        echo "📝 Server logs available at: $TKR_MCP_LOG"
        echo "📋 PID stored in: $TKR_MCP_PID"
        
        # Double-check it's actually our server using our utility function
        if is_tkr_mcp_server_running; then
            echo "🔍 Server verification: CONFIRMED - TKR Project Kit MCP server is running"
            return 0
        else
            echo "⚠️  Server verification: WARNING - Process may not have started correctly"
            return 1
        fi
    else
        echo "❌ Failed to start TKR Project Kit MCP Knowledge Graph server"
        echo "📝 Check logs at: $TKR_MCP_LOG"
        return 1
    fi
}

# Pretool hook - called before every tool execution
pretool_hook() {
    local tool_name="$1"
    local tool_args="$2"
    
    # Only act on knowledge graph related tools
    if check_knowledge_graph_tool "$tool_name" "$tool_args"; then
        echo "🧠 Knowledge graph operation detected: $tool_name"
        
        # Ensure TKR Project Kit MCP server is running
        if ! start_tkr_mcp_server; then
            echo "⚠️  Warning: MCP server failed to start, knowledge graph operations may not work"
            echo "💡 Try running: cd _project/mcp-knowledge-graph && npm run build && node dist/index.js"
        fi
    fi
}

# Main hook execution
case "${HOOK_TYPE:-pretool}" in
    "pretool")
        pretool_hook "$@"
        ;;
    *)
        # Default behavior for other hook types
        ;;
esac