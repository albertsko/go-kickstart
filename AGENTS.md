### Commands

| Command                    | Action                                             |
| -------------------------- | -------------------------------------------------- |
| `mise run fmt`             | Format Go, shell, and markdown.                    |
| `mise run fmt --check`     | Check formatting only.                             |
| `mise run lint`            | Lint Go, shell, and workflows.                     |
| `mise run test`            | Run Go tests.                                      |
| `mise run test -run TestX` | Pass arguments to `go test`.                       |
| `mise run build`           | Build `bin/go-kickstart`.                          |
| `mise run ci`              | Run all checks. A change is done when this passes. |
| `mise run release-check`   | Validate `.goreleaser.yaml`.                       |
| `mise run clean`           | Remove build output and the test cache.            |
| `mise run brew`            | Install the tools with Homebrew.                   |
| `mise run deps`            | Check that the tools are installed.                |

### Tools

- Install with `mise run brew` or `mise install`. Installed mise tools win over Homebrew.
- Add a tool to `tasks/ci/Brewfile` and `[tools]` in `mise.toml`.

### Commits

- Commit and push only when asked.
- Use _Conventional Commits_ for commits and pull request titles. Mark breaking changes with `!`.
- The squash merge uses the pull request title.

### CI

- Put task scripts in `tasks/`, linked with `file =` in `mise.toml`.
- Put CI-only files in `tasks/ci/`.
- CI installs every tool from `tasks/ci/Brewfile`.

### Releases

- Tag with `git tag -a v1.2.3 -m "Summary."` and push. Lightweight tags fail.
- The tag message opens the release notes.

### This file

- `CLAUDE.md` is a symlink to `AGENTS.md`.
- Update the Commands table when `mise.toml` tasks change.
- Write each list item on one line.
