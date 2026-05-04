#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHANGELOG="$REPO_ROOT/CHANGELOG.md"

echo "# Changelog" > "$CHANGELOG"

mapfile -t TAGS < <(git -C "$REPO_ROOT" tag --sort=-version:refname)

if [ ${#TAGS[@]} -eq 0 ]; then
  echo "" >> "$CHANGELOG"
  echo "No releases yet." >> "$CHANGELOG"
  exit 0
fi

for i in "${!TAGS[@]}"; do
  TAG=${TAGS[$i]}
  DATE=$(git -C "$REPO_ROOT" log -1 --format=%aI "$TAG" | cut -dT -f1)

  echo "" >> "$CHANGELOG"
  echo "## $TAG ($DATE)" >> "$CHANGELOG"

  # Determine commit range
  if [ $((i + 1)) -lt ${#TAGS[@]} ]; then
    PREV=${TAGS[$((i + 1))]}
    RANGE="$PREV..$TAG"
  else
    RANGE="$TAG"
  fi

  # Collect commits by category
  BREAKING=$(git -C "$REPO_ROOT" log "$RANGE" --pretty="- %s (%h)" --no-merges --grep="^feat.*!:\|BREAKING CHANGE" --extended-regexp 2>/dev/null || true)
  FEATS=$(git -C "$REPO_ROOT" log "$RANGE" --pretty="- %s (%h)" --no-merges --grep="^feat" --extended-regexp 2>/dev/null || true)
  FIXES=$(git -C "$REPO_ROOT" log "$RANGE" --pretty="- %s (%h)" --no-merges --grep="^fix" --extended-regexp 2>/dev/null || true)
  OTHER=$(git -C "$REPO_ROOT" log "$RANGE" --pretty="- %s (%h)" --no-merges --grep="^feat\|^fix" --extended-regexp --invert-grep 2>/dev/null || true)

  # Remove breaking changes from features to avoid duplication
  if [ -n "$BREAKING" ]; then
    echo "" >> "$CHANGELOG"
    echo "### ⚠ Breaking Changes" >> "$CHANGELOG"
    echo "$BREAKING" >> "$CHANGELOG"
    # Filter out breaking from feats
    FEATS=$(echo "$FEATS" | grep -v "!" || true)
  fi

  if [ -n "$FEATS" ]; then
    echo "" >> "$CHANGELOG"
    echo "### Features" >> "$CHANGELOG"
    echo "$FEATS" >> "$CHANGELOG"
  fi

  if [ -n "$FIXES" ]; then
    echo "" >> "$CHANGELOG"
    echo "### Fixes" >> "$CHANGELOG"
    echo "$FIXES" >> "$CHANGELOG"
  fi

  if [ -n "$OTHER" ]; then
    echo "" >> "$CHANGELOG"
    echo "### Other" >> "$CHANGELOG"
    echo "$OTHER" >> "$CHANGELOG"
  fi
done

echo "" >> "$CHANGELOG"
echo "✓ Generated $CHANGELOG"
