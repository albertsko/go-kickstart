Less setup, more Go! 🚀

A GitHub template for a Go command-line program, with strict linting, a task runner, CI, and releases ready to use.

### What you get

- `cmd/go-kickstart/`: a small CLI with a `-version` flag and a test.
- `./run`: a task runner script instead of a Makefile. `./run help` lists the tasks.
- `ci/`: the `Brewfile` with every tool, including Go, and the scripts the workflows call.
- `.golangci.yml`: a strict golangci-lint setup with gofumpt and goimports.
- `.github/workflows/`: checks on every pull request and push to `main`, and releases from annotated tags.
- `.goreleaser.yaml`: binaries for linux, darwin, and windows, checksums, and release notes grouped by [Conventional Commits](https://www.conventionalcommits.org/).
- `AGENTS.md`: repository conventions for people and coding agents.

### Start a project

1. Click **Use this template** on GitHub and clone your new repository.
2. Rename the module, program, and `cmd/` directory:

   ```sh
   ./run init github.com/you/app
   ```

3. Install the tools with [Homebrew](https://brew.sh) and run the checks:

   ```sh
   ./run brew
   ./run ci
   ```

4. Review the changes with `git diff` and commit them.

### Release

```sh
git tag -a v0.1.0 -m "First release."
git push origin v0.1.0
```
