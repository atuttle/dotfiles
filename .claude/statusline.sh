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

# Ralph to-do count
RALPH_TODO=""
if [ -f ".ralph/prd.json" ]; then
    TODO_COUNT=$(cat .ralph/prd.json | grep -E '"passes": false|"status": "pending"' | wc -l | xargs)
    RALPH_TODO=" | RALPH TODO: ${TODO_COUNT}"
fi

echo "[$MODEL] Context: ${TOKENS_USED} / ${CONTEXT_MAX} | +${LINES_ADDED}/-${LINES_REMOVED} | 📂 ${FOLDER_NAME}${GIT_INFO}${RALPH_TODO}"
