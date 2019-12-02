#!/usr/bin/env bash
set -euo pipefail

function to_markdown_link() {
  DATE=$(basename "$1" .md | sed -e "s/src\///")
  if [ "$DATE" == "#" ]; then
    echo "<a href=\"#\">#</a>"
  else
    echo "<a href=\"./$DATE.html\">$DATE</a>"
  fi
}

LIST=$(cat << EOF
src/#
$(ls src/*.md | sort -nr)
src/#
EOF
)

CONTEXT=$(grep -C1 "$1" <<< "$LIST")
NEXT=$(to_markdown_link "$(head -n 1 <<< "$CONTEXT")")
PREV=$(to_markdown_link "$(tail -n 1 <<< "$CONTEXT")")
INDEX='<a href="./index.html">index</a>'
echo -e "$PREV\\n$INDEX\\n$NEXT"
