# go-kickstart

Go command-line program, created from a GitHub template. The program lives in `cmd/go-kickstart/`.

## Workflow

- Run every task through `./run`, the same entry point CI uses. `./run help` lists the tasks, and the `task_*` functions in `run` show what each task does.
- A change is done when `./run ci` passes. Run `./run fmt` first to fix formatting. Pass extra arguments to `go test` with `./run test`, for example `./run test -run TestRun`.
- Install the tools from `ci/Brewfile`, including Go, with `./run brew`.
- After creating a repository from the template, run `./run init <module>` once. It rewrites the module path and program name in every tracked file, including this one, and moves the `cmd/` directory.
- Give the repository a git remote before `./run release-check`, because goreleaser takes the project name from the remote.

## Commits

- Commit and push only when asked.
- Write commit messages and pull request titles as [Conventional Commits](https://www.conventionalcommits.org/), for example `feat:`, `fix:`, `docs:`, `chore:`. Mark breaking changes with `!`. The squash merge uses the pull request title, and the release notes group commits by type.
- Use `feat` or `fix` for changes users see, because the release notes list only those types and breaking changes.

## Go

- Keep `main` thin. Put program logic in `run`, which takes its arguments and writers so tests can call it.
- Fix lint findings in the code. For a real false positive, add `//nolint:<linter> // <reason>`.

## Shell

- Start scripts with `#!/usr/bin/env bash` and `set -euo pipefail`. Report errors with a `die()` helper, as `run` does.
- Write for bash 3.2 (stock macOS). Read lists with `while read` loops.

## CI

- Put CI logic in `ci/*.sh` or `./run` tasks. Give each workflow `run:` step one command.
- Pin GitHub Actions to a full commit SHA, with the version in a comment. Dependabot updates the pins.
- Add tools to `ci/Brewfile`, so local runs and CI use the same versions.

## Releases

Create release tags as annotated tags, for example `git tag -a v1.2.3 -m "Summary."`, and push them. `ci/release.sh` rejects lightweight tags. The tag message becomes the summary at the top of the release notes. The release workflow runs the checks before goreleaser publishes.

## This file

- Edit `AGENTS.md`. `CLAUDE.md` is a symlink to it.
- Write each prose paragraph and list item on one line.
