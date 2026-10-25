<div align="center">
    <b>Less setup, more Go! 🚀</b>

[![Check](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml/badge.svg)](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml)
[![Go 1.27](https://img.shields.io/badge/go-1.27-00ADD8?logo=go)](go.mod)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.md)
</div>

### Kickstart

[Use this template](https://github.com/albertsko/go-kickstart/generate), clone it, and run:

```sh
brew install mise                    # or: curl https://mise.run | sh
mise trust                           # allow the tasks in mise.toml
mise run setup                       # install the tools
mise run init github.com/you/app     # rename the project
mise run ci                          # run every check
```

`mise run setup` uses Homebrew when you have it. Without Homebrew, it installs the tools with mise and records that choice in `.miserc.local.toml`. To use mise tools with Homebrew installed, put `env = ["tools"]` in `.miserc.local.toml` before `mise run setup`.

### Contents

- 🧹 **Linters**, strict from day one.
- 🏃 **Task runner**, `mise run`, for you and CI.
- 🍺 **Brewfile** for every tool, Go included, or `mise` if you prefer.
- 📦 **Releases** for Linux, macOS, and Windows.

### Release

```sh
git tag -a v0.1.0 -m "First release."
git push origin v0.1.0
```

The tag message opens the release notes, and commits are grouped by [Conventional Commits](https://www.conventionalcommits.org/).
