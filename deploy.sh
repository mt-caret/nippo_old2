#!/usr/bin/env bash
set -euo pipefail
cd build
git add .
git commit -m "$(date +'%F %R:%S')" || true
git push origin master
