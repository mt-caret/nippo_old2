#!/usr/bin/env bash
set -euo pipefail
D=$(date +%F)
FP="src/$D.md"
LAST_ENTRY=$(find src/ -name '*.md' | sort -nr | head -n 1)
TEMPLATE=$(cat << EOF
---
title: log $D
---

EOF
)
if [ -f "$FP" ]; then
  echo "file already exists at $FP"
  exit 1
else
  echo "creating entry at $FP"
  echo "$TEMPLATE" > "$FP"
  if [ ! -z "$LAST_ENTRY" ]; then
    echo "touching $LAST_ENTRY"
    touch "$LAST_ENTRY"
  fi
fi
