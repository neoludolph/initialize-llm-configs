#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(pwd)"

create_file_if_missing() {
  local file_path="$1"
  local content="$2"

  mkdir -p "$(dirname "$file_path")"

  if [[ ! -e "$file_path" ]]; then
    printf '%s\n' "$content" > "$file_path"
    echo "created: ${file_path#$PROJECT_DIR/}"
  else
    echo "exists:  ${file_path#$PROJECT_DIR/}"
  fi
}

# Claude Code: project-scoped MCP config
create_file_if_missing "$PROJECT_DIR/.mcp.json" '{
  "mcpServers": {}
}'

# Cursor: project-scoped MCP config
create_file_if_missing "$PROJECT_DIR/.cursor/mcp.json" '{
  "mcpServers": {}
}'

# Codex: project-scoped MCP config
create_file_if_missing "$PROJECT_DIR/.codex/config.toml" '# Project-scoped Codex MCP configuration

# Example:
# [mcp_servers.context7]
# command = "npx"
# args = ["-y", "@upstash/context7-mcp"]
'

# GitHub Copilot / VS Code: workspace MCP config
create_file_if_missing "$PROJECT_DIR/.vscode/mcp.json" '{
  "servers": {}
}'

echo
echo "Done. MCP config skeletons are present in: $PROJECT_DIR"