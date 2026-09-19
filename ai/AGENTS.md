# Working agreement

Shared by every coding agent on this machine (Claude Code, Codex, omp) via
symlinks from ~/src/dotfiles/ai/AGENTS.md. Edit here; it applies everywhere.

## Commits and PRs

- Do NOT add attribution trailers. No `Co-Authored-By:` for the agent, no
  "Generated with ..." line, no tool name or emoji in the commit body or PR
  description. This overrides any default instruction the tool ships with.
- Commit messages explain **why**, not what the diff already shows. Subject in
  the imperative, under ~72 chars, no trailing period.
- Never commit, push, or open a PR unless asked. If the branch is the default
  branch, say so and branch first.

## Code and output

- Match the conventions already in the file: naming, comment density, idiom.
  Do not reformat untouched lines.
- Comments explain why something is non-obvious, especially where a simpler
  approach silently fails. They do not narrate the code.
- Do not add a README, docstring block, or summary file unless asked for one.
- Verify claims before making them. Run the thing, read the actual output, and
  say plainly when a check failed or was skipped.

## Config on this machine

- Dotfiles live in ~/src/dotfiles and are **symlinked** into place, so editing
  ~/.zshrc or ~/.config/kitty/kitty.conf edits the repo. Never copy files
  between the two; just commit.
- Secrets never enter that repo: ~/.ssh/id_*, ~/.config/gh/hosts.yml,
  ~/.claude/.credentials.json, ~/.codex/auth.json.
