<div align="center">
    <h3>Kickstart a Go project! 🚀</h3>
    <h5>Go project template with linting, tests, CI, and cross-platform releases built in.</h5>

[![Check](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml/badge.svg)](https://github.com/albertsko/go-kickstart/actions/workflows/check.yml)
[![Go 1.27](https://img.shields.io/badge/go-1.27-00ADD8?logo=go)](go.mod)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.md)
</div>

### Kickstart

[Use this template](https://github.com/albertsko/go-kickstart/generate), clone it, and run:

```
curl https://mise.run | sh    # install mise
mise trust                    # allow the project configuration and tasks
mise install                  # install the tools
./init.sh github.com/you/app  # rename the project
mise run ci                   # run every check
```

### Contents

- 🧹 **Linters**, clean from day one.
- ✨ **Formatters** for Go, shell, and Markdown.
- 🏃 **Tasks** with `mise run`.
- 🧑‍🍳 **Tools** from `mise`.
- ✅ **CI** on GitHub Actions, with cached tools and Go builds.
- 📦 **Releases** for Linux, macOS, and Windows.
- 🤖 **Updates** for mise tools, Go modules, and GitHub Actions.

### Release

```sh
git tag -a v0.1.0 -m "First release."
git push origin v0.1.0
```

The tag message opens the release notes, and commits are grouped by [Conventional Commits](https://www.conventionalcommits.org/).
