Go command-line program in `cmd/go-kickstart/`. The tooling is ready to use: every task runs through `mise run`, the same entry point CI uses.

### Commands

| Command                    | What it does                                                                         |
| -------------------------- | ------------------------------------------------------------------------------------ |
| `mise run fmt`             | Format Go, shell, and markdown.                                                      |
| `mise run fmt --check`     | Report formatting problems without changing files.                                   |
| `mise run lint`            | Run golangci-lint, `go mod tidy -diff`, `go fix -diff`, shellcheck, and jactionlint. |
| `mise run test`            | Run Go tests with the race detector, in shuffled order.                              |
| `mise run test -run TestX` | Pass extra arguments to `go test`.                                                   |
| `mise run build`           | Build `bin/go-kickstart`.                                                            |
| `mise run ci`              | Run everything CI runs. A change is done when this passes.                           |
| `mise run release-check`   | Validate `.goreleaser.yaml`.                                                         |
| `mise run clean`           | Remove `bin/`, `dist/`, and the Go test cache.                                       |
| `mise run setup`           | Install the tools with Homebrew, or with mise when Homebrew is missing.              |
| `mise run brew`            | Install or upgrade the tools in `ci/Brewfile`.                                       |
| `mise run deps`            | Check that the tools from Homebrew or mise are installed.                            |

### Tools

- Two local setups: Homebrew tools (the default) or mise tools. `mise run setup` picks mise when Homebrew is missing and writes `env = ["tools"]` to `.miserc.local.toml`, which loads `mise.tools.toml`. To pick mise with Homebrew installed, write that file yourself.
- CI always uses Homebrew. It never loads `mise.tools.toml`, because `.miserc.local.toml` is gitignored.
- Add a tool to both `ci/Brewfile` and `mise.tools.toml`. Keep `[tools]` out of `mise.toml`, so CI uses only Homebrew.

### Commits

- Commit and push only when asked.
- Write commit messages and pull request titles as [Conventional Commits](https://www.conventionalcommits.org/), for example `feat:`, `fix:`, `docs:`, `chore:`. Mark breaking changes with `!`. The squash merge uses the pull request title.
- Pick the type that fits the change. The release notes list breaking changes, features, and fixes first, and every other type under "Other changes".

### CI

- Put task and CI logic in `ci/*.sh`, and point a task at its script with `file =` in `mise.toml`. Keep only one-line commands inline, so shfmt and shellcheck see all bash. Give each workflow `run:` step one command.
- Pin GitHub Actions to a full commit SHA, with the version in a comment. Dependabot updates the pins.
- CI installs every tool, mise included, from `ci/Brewfile`, and sets `MISE_TASK_RUN_AUTO_INSTALL=0` so mise never installs its own.

### Releases

Create release tags as annotated tags, for example `git tag -a v1.2.3 -m "Summary."`, and push them. `ci/release.sh` rejects lightweight tags. The tag message becomes the summary at the top of the release notes. The release workflow runs the checks before goreleaser publishes.

### This file

- Edit `AGENTS.md`. `CLAUDE.md` is a symlink to it.
- When `mise.toml` tasks change, update the Commands table.
- Write each prose paragraph and list item on one line.
