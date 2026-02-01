# set error mode to ensure any errors are thrown
set -e

claude --permission-mode acceptEdits -p "study @.ralph/prd.json
study @.ralph/progress.md

1. Find the highest-priority item to work on and work only on that item. This should be the one YOU decide has the highest priority - not necessarily the first item in the list.
2. If this is a Typescript project, check that the types check via `npm run check` (if available, else `npx tsc --noEmit`)
3. If there are tests, run them to ensure they pass.
4. Update the PRD with the work that was done.
5. Append your progress to the progress.md file. Use this to leave a note for the next person workin in the codebase.
6. Make a git commit of that feature.

ONLY WORK ON A SINGLE FEATURE."
