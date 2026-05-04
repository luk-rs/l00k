# Copilot Instructions

> Instructions for GitHub Copilot. Read `AGENTS.md` at the repo root for full
> project context.

## Project summary

**l00k** is a modular TradingView Pine Script v6 indicator. Individual `.pine`
files in `src/` are concatenated into a unified script by CI and published to a
GitHub Gist on every push to `main`.

## When writing Pine Script

- Target Pine Script **v6** syntax and built-ins.
- Do NOT add `//@version=6` or `indicator()` calls — these exist only in
  `src/00_meta.pine`.
- Name new files with numeric prefixes matching their role. Prefer
  self-contained indicator/strategy slices in the `50-79` range; use shared
  input/helper/plot ranges only when another slice genuinely reuses the code.
- Ensure no duplicate function or variable names across files.

## When committing

- Use **Conventional Commits**: `feat:`, `fix:`, `feat!:`, `chore:`, etc.
- CI auto-bumps semantic version from commit messages.
- Do not edit `CHANGELOG.md`, `.gist_id`, or create version tags.

## Maintenance

After structural changes, update `AGENTS.md`, `CLAUDE.md`, and this file.
