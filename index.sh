#!/usr/bin/env bash
set -euo pipefail

cat << EOF
---
title: log
---
<!-- no RSS feeds, check back every day :love: -->
EOF
ls src/*.md | sort -nr |
while read -r f; do
  date=$(basename "$f" .md | sed -e "s/src\///")
  echo "- [$date](./$date.html)"
done

