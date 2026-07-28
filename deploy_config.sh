#!/usr/bin/env bash
# Push this repository's terminal configuration out to $HOME.
# Existing files are overwritten; nothing in ~ is deleted.
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

cp .zshrc .wezterm.lua "$HOME/"

mkdir -p "$HOME/.config"
# --prune-empty-dirs: a branch switch can leave empty directory skeletons
# behind (git does not track empty dirs); don't propagate them into ~.
rsync -a --prune-empty-dirs --exclude '.git/' ./.config/ "$HOME/.config/"

chmod +x "$HOME/.config/.lessfilter"

echo "done. start a new shell to pick up .zshrc."
