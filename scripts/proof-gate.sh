#!/bin/bash
# PreToolUse hook: Before writing to a prds/ directory, verify the proof
# protocol has been considered. This is a gate — it reminds Claude to run
# the validation loop from quality_bar.md before presenting any artifact.

# Read the tool input from stdin
INPUT=$(cat)

# Extract the file path
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//' | sed 's/"$//')

# Only trigger for writes to a prds/ directory
if echo "$FILE_PATH" | grep -qE '/prds/'; then
  echo "GATE: You are writing to the prds/ directory. Before proceeding:"
  echo "1. Have you re-read the entire artifact end-to-end?"
  echo "2. Have you verified all cross-references resolve?"
  echo "3. Have you checked story numbers are continuous?"
  echo "4. Have you confirmed implementation decisions don't contradict user stories?"
  echo "5. Have you verified Out of Scope items aren't accidentally covered by stories?"
  echo "6. Have you checked dependency tables match what the PRD actually consumes/provides?"
  echo "This is the proof protocol from quality_bar.md. Do not write until the loop is complete."
fi
