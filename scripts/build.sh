#!/usr/bin/env bash
set -euo pipefail

VERSION=${1:?"Usage: build.sh <version> <commit_sha>"}
SHA=${2:?"Usage: build.sh <version> <commit_sha>"}
SHORT_SHA=${SHA:0:7}
DATE=$(date -u +%Y-%m-%d)

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$REPO_ROOT/src"
DIST_DIR="$REPO_ROOT/dist"
OUTPUT="$DIST_DIR/l00k.pine"

mkdir -p "$DIST_DIR"

# Start with version header comment (before //@version directive)
cat > "$OUTPUT" << EOF
// ┌──────────────────────────────────────────────┐
// │  l00k v${VERSION}                             
// │  ${DATE} · ${SHORT_SHA}                       
// │  https://github.com/luk-rs/l00k              
// └──────────────────────────────────────────────┘
EOF

# Concatenate all .pine source files in lexicographic order
FOUND=0
for file in "$SRC_DIR"/*.pine; do
  [ -f "$file" ] || continue
  FOUND=1
  BASENAME=$(basename "$file")
  printf '\n// ─── %s ───\n' "$BASENAME" >> "$OUTPUT"
  cat "$file" >> "$OUTPUT"
done

if [ "$FOUND" -eq 0 ]; then
  echo "ERROR: No .pine files found in $SRC_DIR" >&2
  exit 1
fi

# Ensure trailing newline
echo "" >> "$OUTPUT"

echo "✓ Built l00k v${VERSION} → ${OUTPUT}"
