---
name: code-stats
description: Analyze a codebase directory and report statistics (file counts by type, line counts, largest files)
---
Analyze the codebase at the path given by $ARGUMENTS (default: current working directory).

Report the following statistics:
1. **File counts by extension** — how many .js, .ts, .py, .md, etc. files exist
2. **Total line counts** by file type
3. **Top 5 largest files** by line count
4. **Directory structure overview** — top-level directories and their purpose (inferred)

Use Glob to find files and Read to sample files when needed. Keep output concise and well-formatted as a markdown table where appropriate.
