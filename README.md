# satoramoto/tap

Homebrew formulae for [satoramoto](https://github.com/satoramoto)'s tools.

```bash
brew install satoramoto/tap/agentmon
```

| Formula | What it is |
|---|---|
| `agentmon` | Terminal monitor for what AI coding agents (Claude, Codex) cost your Mac: per-session CPU, memory, disk and network. macOS only. |

## How the formula is built

`agentmon` is a Ruby gem. The formula installs it and its runtime gems (`r2ui`, `fiddle`) from
RubyGems into the keg's `libexec`, runs them with Homebrew's `ruby`, and puts a wrapper in `bin`
that sets `GEM_HOME`/`GEM_PATH` to `libexec`, so it doesn't see or touch your own Ruby or gems.

## Updates

agentmon's `Homebrew` workflow (`.github/workflows/homebrew.yml` in
[satoramoto/agentmon](https://github.com/satoramoto/agentmon)) runs after each release reaches
RubyGems: it points the formula at the new gems, installs, tests and audits it on macOS, and pushes
here. Run that workflow by hand to retry or to pick up a new r2ui.

To change the formula by hand, check it locally before pushing:

```bash
brew install --build-from-source satoramoto/tap/agentmon
brew test agentmon
brew audit --strict agentmon
```
