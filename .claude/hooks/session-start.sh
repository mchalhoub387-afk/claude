#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

echo '{"async": true, "asyncTimeout": 300000}'

# Add the official marketplace if not already present
if ! claude plugin marketplace list 2>/dev/null | grep -q "claude-plugins-official"; then
  claude plugin marketplace add anthropics/claude-plugins-official 2>/dev/null || true
fi

# Install superpowers plugin if not already installed
if ! claude plugin list 2>/dev/null | grep -q "superpowers"; then
  claude plugin install superpowers@claude-plugins-official --scope project 2>/dev/null || true
fi
