#!/usr/bin/env bash
set -euo pipefail
D=$(date +%F)
FP="src/$D.md"
LAST_ENTRY=$(find src/ -name '*.md' | sort -nr | head -n 1)
TEMPLATE=$(cat << EOF
---
title: log $D
---

<section>

<figure>

|||
|:-|:-:|

</figure>



</section>

## regimen

- [ ] exercise
  - [ ] Fit Boxing
  - [ ] Ring Fit Adventure
- [ ] meta-learning / productivity
  - [ ] survey
  - [ ] book
- [ ] study
  - [ ] duolingo
  - [ ] spaced repetition
  - [ ] quantum computing
  - [ ] compilers and type systems
  - [ ] machine learning
  - [ ] lisp
  - [ ] functional programming
  - [ ] set theory
  - [ ] abstract algebra
  - [ ] linear algebra
  - [ ] numerical analysis
- [ ] misc
  - [ ] migrate password manager
  - [ ] execute program

## daily info

Weight:   
Goal: 65.0kg

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
