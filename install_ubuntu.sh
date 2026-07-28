#!/usr/bin/env bash
# Bootstrap the terminal environment on a fresh Ubuntu box.
# Installs what apt has, then oh-my-zsh and its plugins, then reports
# which of the remaining tools still need a manual install.
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

echo "==> apt packages"
sudo apt-get update
xargs -a pkglist-apt.txt sudo apt-get install -y --no-install-recommends

# eza and zoxide only exist in the ubuntu repos from 24.04 / 23.04 onward.
echo "==> optional apt packages"
for p in eza zoxide fastfetch; do
  sudo apt-get install -y "$p" 2>/dev/null && echo "  $p: apt" \
    || echo "  $p: NOT in this ubuntu's repos - install manually"
done

echo "==> oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  already present"
fi

echo "==> oh-my-zsh custom plugins"
custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$custom"
clone() {  # clone <url> <dir>
  if [ -d "$custom/$2" ]; then echo "  $2: already present"
  else git clone --depth 1 "$1" "$custom/$2" && echo "  $2: cloned"; fi
}
clone https://github.com/Aloxaf/fzf-tab                      fzf-tab
clone https://github.com/zsh-users/zsh-autosuggestions       zsh-autosuggestions
clone https://github.com/zsh-users/zsh-syntax-highlighting   zsh-syntax-highlighting
clone https://github.com/Pilaton/OhMyZsh-full-autoupdate     ohmyzsh-full-autoupdate

echo
echo "==> tools with no apt package - install these yourself:"
for t in nvim starship yazi zellij lazygit lazydocker wezterm vivid; do
  command -v "$t" >/dev/null && echo "  $t: ok" || echo "  $t: MISSING (see README)"
done

# .zshrc uses `fzf --zsh` (needs >= 0.48) and `--style full` (needs >= 0.53).
if command -v fzf >/dev/null; then
  echo "  fzf: $(fzf --version) - needs >= 0.53 for Ctrl-R styling"
fi

echo
echo "next: ./deploy_config.sh && chsh -s \$(which zsh)"
