#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
# Calculate tokens from used_percentage (which represents actual context utilization)
CONTEXT_MAX_RAW=$(echo "$input" | jq -r '.context_window.context_window_size')
USED_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
TOKENS_USED=$(echo "$CONTEXT_MAX_RAW $USED_PCT" | awk '{printf "%d", $1 * $2 / 100}' | xargs printf "%'d")
CONTEXT_MAX=$(echo "$CONTEXT_MAX_RAW" | xargs printf "%'d")
LINES_ADDED=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
LINES_REMOVED=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Current folder name
FOLDER_NAME=$(basename "$(echo "$input" | jq -r '.workspace.current_dir')")

# Git branch + dirty status
GIT_INFO=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        DIRTY=""
        if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
            DIRTY="*"
        fi
        GIT_INFO=" | 🌿 ${BRANCH}${DIRTY}"
    fi
fi

# Ralph incomplete task count
RALPH_INFO=""
PRD_FILE="$HOME/DEV/.ralph/prd.json"
if [ -f "$PRD_FILE" ]; then
    TODO_COUNT=$(jq '[.[].tasks[] | select(.complete == false)] | length' "$PRD_FILE" 2>/dev/null)
    if [ -n "$TODO_COUNT" ] && [ "$TODO_COUNT" -gt 0 ] 2>/dev/null; then
        RALPH_INFO=" | RALPH: ${TODO_COUNT}"
    fi
fi

# Build progress bar (10 chars wide)
BAR_WIDTH=10
FILLED=$(echo "$USED_PCT $BAR_WIDTH" | awk '{printf "%d", ($1 / 100) * $2 + 0.5}')
EMPTY=$(( BAR_WIDTH - FILLED ))
BAR=""
for i in $(seq 1 $FILLED); do BAR="${BAR}█"; done
for i in $(seq 1 $EMPTY); do BAR="${BAR}░"; done

echo "[$MODEL] ${TOKENS_USED} / ${CONTEXT_MAX} ${BAR} | +${LINES_ADDED}/-${LINES_REMOVED} | 📂 ${FOLDER_NAME}${GIT_INFO}${RALPH_INFO}"
