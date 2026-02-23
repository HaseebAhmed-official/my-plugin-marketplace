#!/usr/bin/env python3
"""PostToolUse hook: Comprehensive audit trail for all tool usage."""
import json, sys
from datetime import datetime

data = json.load(sys.stdin)
tool = data.get("tool_name", "unknown")
inputs = data.get("tool_input", {})

detail_map = {
    "Bash": lambda: inputs.get("command", "")[:200],
    "Write": lambda: inputs.get("file_path", ""),
    "Edit": lambda: inputs.get("file_path", ""),
    "Read": lambda: inputs.get("file_path", ""),
    "Glob": lambda: inputs.get("pattern", ""),
    "Grep": lambda: inputs.get("pattern", ""),
}

detail = detail_map.get(tool, lambda: ", ".join(inputs.keys()))()
timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open("/tmp/claude-audit-log.txt", "a") as f:
    f.write(f"[{timestamp}] {tool} | {detail}\n")

sys.exit(0)
