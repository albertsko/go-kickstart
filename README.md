<div align="center">

### Less setup, more Go! 🚀

[![Check](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml/badge.svg)](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml)
[![Go 1.27](https://img.shields.io/badge/go-1.27-00ADD8?logo=go)](go.mod)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.md)

Opinionated GitHub template for a Go project.

</div>

### What you get

- 🧹 **70 linters**, strict from day one.
- 🧪 **Race-checked tests** in shuffled order.
- 🏃 **One task runner**, `./run`, for you and CI.
- 🍺 **One Brewfile** for every tool, Go included.
- 📦 **Releases from one tag** for Linux, macOS, and Windows.
- 🤖 **Ready for coding agents** with `AGENTS.md`.

### Quickstart

[Use this template](https://github.com/albertsko/go-kickstart/generate), clone it, and run:

```sh
./run brew                       # install the tools with Homebrew
./run init github.com/you/app    # rename the project
./run ci                         # run every check
```

### Release

```sh
git tag -a v0.1.0 -m "First release."
git push origin v0.1.0
```

The tag message opens the release notes, and commits are grouped by [Conventional Commits](https://www.conventionalcommits.org/).
