#!/usr/bin/env python3
"""PreToolUse hook: Block dangerous bash commands.
Exit 0 = allow, Exit 2 = block (stderr shown to user).
"""
import json, sys, re

data = json.load(sys.stdin)

if data.get("tool_name") != "Bash":
    sys.exit(0)

command = data.get("tool_input", {}).get("command", "")

DANGEROUS_PATTERNS = [
    r"rm\s+-rf\s+/",
    r"rm\s+-rf\s+~",
    r"rm\s+-rf\s+\$HOME",
    r"git\s+push\s+--force.*(main|master)",
    r"git\s+push\s+-f.*(main|master)",
    r"chmod\s+-R\s+777",
    r":\(\)\{\s*:\|:&\s*\};:",
    r">\s*/dev/sda",
    r"mkfs\.",
    r"dd\s+if=.*/dev/",
]

for pattern in DANGEROUS_PATTERNS:
    if re.search(pattern, command, re.IGNORECASE):
        print(f"BLOCKED: Dangerous command detected (pattern: {pattern})", file=sys.stderr)
        print(f"Command was: {command}", file=sys.stderr)
        sys.exit(2)

sys.exit(0)
