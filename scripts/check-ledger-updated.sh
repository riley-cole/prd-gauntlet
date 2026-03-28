#!/bin/bash
# PostToolUse hook: After writing a PRD artifact, check if the process ledger
# has been updated for the current phase. Fires on Write to any .md file.
#
# This hook reads stdin for the tool use context (JSON), checks if the file
# written is a PRD-related artifact, and outputs a reminder if the process
# ledger hasn't been mentioned recently.

# Read the tool result from stdin
INPUT=$(cat)

# Extract the file path from the tool arguments
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//' | sed 's/"$//')

# Trigger for files that look like PRD artifacts (not the ledger or reconciliation pass itself)
if echo "$FILE_PATH" | grep -qiE '(_prd|stories|component_map|ecosystem_summary|stress_test|decision_log|product_def|define|scope_)' && ! echo "$FILE_PATH" | grep -qiE '(process_ledger|reconciliation_pass)'; then
  echo "REMINDER: You just wrote a PRD artifact. Has the process ledger been updated for the current phase? Each phase appends its section before the phase is declared complete."
fi
