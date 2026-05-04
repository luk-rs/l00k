# CLAUDE.md

> Instructions for Claude-based agents (Claude Code, Warp Oz, etc.).
> Read `AGENTS.md` first — it contains the full project context.

## Quick reference

- **Language:** Pine Script v6
- **Source dir:** `src/` — numeric-prefixed `.pine` files, concatenated in order
- **Build:** `bash scripts/build.sh <version> <sha>`
- **CI:** pushes to `main` auto-version, build, publish gist, tag, changelog
- **Commits:** use Conventional Commits (`feat:`, `fix:`, `feat!:`, etc.)

## Claude-specific guidance

- When creating new indicator files, prefer a self-contained vertical slice
  in the `50-79` range. Move code into `10-49` or `90-99` only when another
  slice genuinely reuses it.
- Never put `//@version=6` or `indicator()` in any file other than
  `src/00_meta.pine`.
- After structural changes, update `AGENTS.md`, this file, and
  `.github/copilot-instructions.md`.
- When asked to add a new indicator/strategy, create it as a new file in `src/`
  with the next available prefix in the `50-79` range.
- Always validate that new code won't break concatenation order (no forward
  references to undefined symbols).
