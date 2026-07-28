# dotfiles — ubuntu

Terminal configuration only. The desktop session (niri, noctalia, qt/gtk theming,
graphical apps) lives on the `arch` branch and is deliberately not carried here.

Shell is zsh + oh-my-zsh + starship, terminal is WezTerm, editor is Neovim.

## Layout

| Path | Contents |
| --- | --- |
| `.zshrc`, `.wezterm.lua` | shell and terminal |
| `.config/nvim` | Neovim (lazy.nvim) |
| `.config/yazi`, `.config/bat`, `.config/btop`, `.config/zellij`, `.config/lazygit`, `.config/lazydocker` | cli tools |
| `.config/starship.toml`, `.config/.ripgrep.rc`, `.config/.lessfilter` | shell helpers |
| `.config/wezterm/colors` | terminal colour scheme |
| `.config/git/ignore` | global gitignore |
| `pkglist-apt.txt` | apt-installable packages |

## Setup

```sh
./install_ubuntu.sh   # apt packages + oh-my-zsh + zsh plugins
./deploy_config.sh    # copy config into ~
chsh -s "$(which zsh)"
```

Then install the tools apt does not carry (see below) and start a new shell.

## Tools with no apt package

`install_ubuntu.sh` reports which of these are missing.

| Tool | Install |
| --- | --- |
| neovim | tarball to `/opt/nvim-linux-x86_64` — `.zshrc` already puts it on `PATH` |
| starship | `curl -sS https://starship.rs/install.sh \| sh` |
| yazi, zellij, vivid | `cargo install yazi-fm yazi-cli zellij vivid` or GitHub releases |
| lazygit, lazydocker | GitHub releases into `~/.local/bin` |
| wezterm | wezterm apt repo, or the `.deb` from GitHub releases |
| eza, zoxide | in the ubuntu repos from 24.04 / 23.04; otherwise cargo or GitHub |

**fzf version matters.** `.zshrc` uses `fzf --zsh` (fzf >= 0.48) and `--style full`
(fzf >= 0.53). Older packaged builds are handled gracefully — the key bindings are
skipped rather than erroring — but Ctrl-R styling needs a current release. Install
from GitHub releases if apt's is behind.

## Differences from the `arch` branch

- `bat` and `fd` are `batcat` and `fdfind` on Ubuntu — `.zshrc` and `.lessfilter`
  use those names, with `bat`/`fd` aliases for interactive use.
- `fzf`, `zoxide`, `vivid` and `starship` calls in `.zshrc` are guarded by
  `command -v`, so a missing tool doesn't break shell startup.
- The `vim-niri-nav` Neovim plugin and its `g:vim_niri_nav_workspace` setting are
  removed; window navigation there is niri-specific.
- `.wezterm.lua` resolves its colour scheme via `wezterm.home_dir` rather than a
  hardcoded `/home/val` path.
- No `.tmux.conf` — zellij replaced tmux.

The Noctalia colour scheme is kept for wezterm, btop, yazi and starship. Those
theme files are self-contained, so they work without noctalia installed; nothing
regenerates them on this branch.

## Scripts

```sh
./cp_config.sh       # pull live config from ~ into this repo (mirrors deletions)
./deploy_config.sh   # push this repo's config out to ~
```

## Not tracked

- `.config/nvim/lazy-lock.json` — plugins resolve on first start.
- `~/.gitconfig` — kept machine-local so the work identity stays off GitHub.
