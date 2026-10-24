Go command-line program in `cmd/go-kickstart/`. The tooling is ready to use: every task runs through `./run`, the same entry point CI uses.

### Commands

| Command                 | What it does                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------ |
| `./run fmt`             | Format Go, shell, and markdown.                                                      |
| `./run fmt --check`     | Report formatting problems without changing files.                                   |
| `./run lint`            | Run golangci-lint, `go mod tidy -diff`, `go fix -diff`, shellcheck, and jactionlint. |
| `./run test`            | Run Go tests with the race detector, in shuffled order.                              |
| `./run test -run TestX` | Pass extra arguments to `go test`.                                                   |
| `./run build`           | Build `bin/go-kickstart`.                                                            |
| `./run ci`              | Run everything CI runs. A change is done when this passes.                           |
| `./run release-check`   | Validate `.goreleaser.yaml`.                                                         |
| `./run clean`           | Remove `bin/`, `dist/`, and the Go test cache.                                       |

### Commits

- Commit and push only when asked.
- Write commit messages and pull request titles as [Conventional Commits](https://www.conventionalcommits.org/), for example `feat:`, `fix:`, `docs:`, `chore:`. Mark breaking changes with `!`. The squash merge uses the pull request title.
- Pick the type that fits the change. The release notes list breaking changes, features, and fixes first, and every other type under "Other changes".

### Go

- Keep `main` thin. Put program logic in `run`, which takes its arguments and writers so tests can call it.
- Fix lint findings in the code. For a real false positive, add `//nolint:<linter> // <reason>`.

### Shell

- Start scripts with `#!/usr/bin/env bash` and `set -euo pipefail`. Report errors with a `die()` helper, as `run` does.
- Write for bash 3.2 (stock macOS). Read lists with `while read` loops.

### CI

- Put CI logic in `ci/*.sh` or `./run` tasks. Give each workflow `run:` step one command.
- Pin GitHub Actions to a full commit SHA, with the version in a comment. Dependabot updates the pins.
- Add tools to `ci/Brewfile`, so local runs and CI use the same versions.

### Releases

Create release tags as annotated tags, for example `git tag -a v1.2.3 -m "Summary."`, and push them. `ci/release.sh` rejects lightweight tags. The tag message becomes the summary at the top of the release notes. The release workflow runs the checks before goreleaser publishes.

### This file

- Edit `AGENTS.md`. `CLAUDE.md` is a symlink to it.
- When `./run` tasks change, update the Commands table.
- Write each prose paragraph and list item on one line.
