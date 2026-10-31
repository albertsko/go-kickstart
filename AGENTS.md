### Commands

| Command                    | Action                                             |
| -------------------------- | -------------------------------------------------- |
| `mise run fmt`             | Format Go, shell, and markdown.                    |
| `mise run fmt --check`     | Check formatting only.                             |
| `mise run lint`            | Lint Go, shell, and workflows.                     |
| `mise run test`            | Run Go tests. CI also shuffles the test order.     |
| `mise run test -run TestX` | Pass arguments to `go test`.                       |
| `mise run build`           | Build `bin/go-kickstart`.                          |
| `mise run start`           | Build and run `bin/go-kickstart`.                  |
| `mise run ci`              | Run all checks. A change is done when this passes. |
| `mise run release-check`   | Validate `.goreleaser.yaml`.                       |
| `mise run clean`           | Remove build output and the test cache.            |
| `mise run deps`            | Check that the tools are installed.                |
| `mise run upgrade`         | Upgrade all mise tools, including Go.              |

### Tools

- Install with `mise install`.
- Add a tool to `[tools]` in `mise.toml`.
- When adding a Go module dependency, run `golangci-lint linters` and check for a linter for that dependency.

### Commits

- Commit and push only when asked.
- Use _Conventional Commits_ for commits and pull request titles. Mark breaking changes with `!`.
- The squash merge uses the pull request title.

### CI

- Put executable task scripts in `tasks/` with their descriptions in `#MISE` headers.
- CI installs the tools configured in `mise.toml`.

### Releases

- Tag with `git tag -a v1.2.3 -m "Summary."` and push. Lightweight tags fail.
- The tag message opens the release notes.

### This file

- `CLAUDE.md` is a symlink to `AGENTS.md`.
- Update the Commands table when tasks change.
- Write each list item on one line.
