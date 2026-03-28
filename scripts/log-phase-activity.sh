#!/bin/bash
# PostToolUse hook (async): Log file writes during a gauntlet run for
# audit trail purposes. Appends to a session-specific log file in the
# project workspace.
#
# This runs async — it doesn't block the gauntlet workflow.

# Read tool result from stdin
INPUT=$(cat)

# Extract file path
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//' | sed 's/"$//')

# Only log .md file writes (skip non-artifact files)
if echo "$FILE_PATH" | grep -qE '\.md$'; then
  TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  LOG_LINE="$TIMESTAMP | WRITE | $FILE_PATH"

  # Log to the skill's local log (rotates per session via session ID if available)
  LOG_DIR="${CLAUDE_SKILL_DIR}/logs"
  mkdir -p "$LOG_DIR"

  if [ -n "$CLAUDE_SESSION_ID" ]; then
    LOG_FILE="$LOG_DIR/session_${CLAUDE_SESSION_ID}.log"
  else
    LOG_FILE="$LOG_DIR/activity.log"
  fi

  echo "$LOG_LINE" >> "$LOG_FILE"
fi
