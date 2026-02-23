#!/usr/bin/env python3
"""PostToolUse hook: Log Write/Edit tool usage."""
import json, sys
from datetime import datetime

data = json.load(sys.stdin)
tool = data.get("tool_name", "unknown")
file_path = data.get("tool_input", {}).get("file_path", "unknown")
timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open("/tmp/claude-tool-log.txt", "a") as f:
    f.write(f"[{timestamp}] Tool: {tool} | File: {file_path}\n")

sys.exit(0)
