<div align="center">

### Less setup, more Go! 🚀

[![Check](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml/badge.svg)](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml)
[![Go 1.27](https://img.shields.io/badge/go-1.27-00ADD8?logo=go)](go.mod)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.md)

</div>

### Kickstart

[Use this template](https://github.com/albertsko/go-kickstart/generate), clone it, and run:

```sh
./run brew                       # install the tools with Homebrew
./run init github.com/you/app    # rename the project
./run ci                         # run every check
```

### Contents

- 🧹 **Linters**, strict from day one.
- 🏃 **Task runner**, `./run`, for you and CI.
- 🍺 **Brewfile** for every tool, Go included.
- 📦 **Releases** for Linux, macOS, and Windows.

### Release

```sh
git tag -a v0.1.0 -m "First release."
git push origin v0.1.0
```

The tag message opens the release notes, and commits are grouped by [Conventional Commits](https://www.conventionalcommits.org/).
