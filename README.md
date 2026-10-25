<div align="center">
    <h3>Less setup, more Go! 🚀</h3>

[![Check](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml/badge.svg)](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml)
[![Go 1.27](https://img.shields.io/badge/go-1.27-00ADD8?logo=go)](go.mod)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.md)
</div>

### Kickstart

[Use this template](https://github.com/albertsko/go-kickstart/generate), clone it, and run:

```
curl https://mise.run | sh           # or: brew install mise
mise trust                           # allow the tasks in mise.toml
mise install                         # or: mise run brew
mise run init github.com/you/app     # rename the project
mise run ci                          # run every check
```

### Contents

- 🧹 **Linters**, strict from day one.
- ✨ **Formatters** for Go, shell, and Markdown.
- 🏃 **Tasks** with `mise run`.
- 🧑‍🍳 **Tools** from `mise` or `brew`.
- ✅ **CI** on GitHub Actions, with a cached Homebrew.
- 📦 **Releases** for Linux, macOS, and Windows.
- 🤖 **Dependabot** for Go modules and GitHub Actions.

### Release

```sh
git tag -a v0.1.0 -m "First release."
git push origin v0.1.0
```

The tag message opens the release notes, and commits are grouped by [Conventional Commits](https://www.conventionalcommits.org/).
