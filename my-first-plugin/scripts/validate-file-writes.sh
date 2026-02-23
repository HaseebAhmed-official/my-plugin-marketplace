#!/usr/bin/env python3
"""PreToolUse hook: Prevent writes to sensitive files.
Exit 0 = allow, Exit 2 = block.
"""
import json, sys, re

data = json.load(sys.stdin)
tool = data.get("tool_name", "")

if tool not in ("Write", "Edit"):
    sys.exit(0)

file_path = data.get("tool_input", {}).get("file_path", "")

BLOCKED_PATTERNS = [
    r"\.env$",
    r"\.env\.",
    r"credentials\.json$",
    r"secrets\.ya?ml$",
    r"\.pem$",
    r"\.key$",
    r"id_rsa",
    r"id_ed25519",
]

for pattern in BLOCKED_PATTERNS:
    if re.search(pattern, file_path, re.IGNORECASE):
        print(f"BLOCKED: Writing to sensitive file not allowed: {file_path}", file=sys.stderr)
        sys.exit(2)

sys.exit(0)
