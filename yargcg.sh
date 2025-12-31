#!/usr/bin/env bash

set -euo pipefail

# REQUIRED ENV VARIABLES

: "${AUTHOR_NAME:?Missing AUTHOR_NAME}"
: "${AUTHOR_EMAIL:?Missing AUTHOR_EMAIL}"
: "${START_DATE:?Missing START_DATE (YYYY-MM-DD)}"
: "${END_DATE:?Missing END_DATE (YYYY-MM-DD)}"

# OPTIONAL ENV VARIABLES

COMMITS_MIN="${COMMITS_MIN:-50}"
COMMITS_MAX="${COMMITS_MAX:-200}"
TARGET_FILE="${TARGET_FILE:-activity.txt}"

START_TS=$(date -d "$START_DATE" +%s)
END_TS=$(date -d "$END_DATE" +%s)

if [[ "$START_TS" -ge "$END_TS" ]]; then
  echo "ERROR: START_DATE must be before END_DATE"
  exit 1
fi

NUM_COMMITS=$((RANDOM % (COMMITS_MAX - COMMITS_MIN + 1) + COMMITS_MIN))
RANGE_SECONDS=$((END_TS - START_TS))

echo "Creating $NUM_COMMITS commits between $START_DATE and $END_DATE"
echo "Author: $AUTHOR_NAME <$AUTHOR_EMAIL>"

touch "$TARGET_FILE"

for ((i=1; i<=NUM_COMMITS; i++)); do
  RANDOM_OFFSET=$((RANDOM * RANDOM % RANGE_SECONDS))
  COMMIT_TS=$((START_TS + RANDOM_OFFSET))

  COMMIT_DATE=$(date -d "@$COMMIT_TS" +"%Y-%m-%dT%H:%M:%S")

  echo "Commit $i at $COMMIT_DATE" >> "$TARGET_FILE"
  git add "$TARGET_FILE"

  GIT_AUTHOR_NAME="$AUTHOR_NAME" \
  GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL" \
  GIT_AUTHOR_DATE="$COMMIT_DATE" \
  GIT_COMMITTER_NAME="$AUTHOR_NAME" \
  GIT_COMMITTER_EMAIL="$AUTHOR_EMAIL" \
  GIT_COMMITTER_DATE="$COMMIT_DATE" \
  git commit -m "Random commit #$i"
done

echo "Done."

