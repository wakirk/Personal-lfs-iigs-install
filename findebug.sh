#!/bin/bash
# Find lines that start with whitespace followed by "read" or "/bin/bash"
# in the current directory and all subdirectories.
# Output: <directory><TAB><filename><TAB><line-number>

grep -R -n -E '^[[:space:]]+(read|/bin/bash).*' --binary-files=without-match -- . \
| while IFS=: read -r path lineno _; do
    dir=$(dirname "$path")
    file=$(basename "$path")
    printf '%s\t%s\t%s\n' "$dir" "$file" "$lineno"
  done
