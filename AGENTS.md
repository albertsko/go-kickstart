### Commands

- Run `mise run <task> [args...]` to execute a task. When no `default` task is defined, bare `mise run` opens the task picker or, outside a terminal, lists tasks and exits with status 1.
- Run `mise run ci` before considering a change complete.

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
- Write each list item on one line.
