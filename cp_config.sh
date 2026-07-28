#!/usr/bin/env bash
# Pull the live terminal configuration from $HOME into this repository.
# Ubuntu branch: terminal tooling only, no desktop/session config.
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

RSYNC=(rsync -a --delete
  --exclude '*.bak'
  --exclude '__pycache__/'
  --exclude '.git/')

# Copy a directory from ~ into the repo, mirroring deletions.
grab_dir() {
  local src="$HOME/$1" dst="./$1"
  [ -d "$src" ] || { echo "skip (missing): $1"; return; }
  mkdir -p "$dst"
  "${RSYNC[@]}" "${@:2}" "$src/" "$dst/"
}

# Copy a single file from ~ into the repo.
grab_file() {
  local src="$HOME/$1" dst="./$1"
  [ -f "$src" ] || { echo "skip (missing): $1"; return; }
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
}

### shell / terminal
grab_file .zshrc
grab_file .wezterm.lua
grab_dir  .config/wezterm

### cli tools
grab_file .config/.lessfilter
grab_file .config/.ripgrep.rc
grab_file .config/starship.toml
grab_file .config/max.png   # nvim dashboard image
grab_dir  .config/nvim --exclude 'lazy-lock.json'
grab_dir  .config/bat
grab_dir  .config/yazi
grab_dir  .config/btop
grab_dir  .config/zellij
grab_dir  .config/lazygit
grab_dir  .config/lazydocker
grab_dir  .config/git

### package list (apt-installable subset only; see README for the rest)
if command -v apt-mark >/dev/null; then
  comm -12 <(apt-mark showmanual | sort) <(sort pkglist-apt.txt) > .pkglist-apt.present
  if ! diff -q pkglist-apt.txt .pkglist-apt.present >/dev/null; then
    echo "note: these tracked apt packages are not installed here:"
    comm -13 .pkglist-apt.present pkglist-apt.txt | sed 's/^/  /'
  fi
  rm -f .pkglist-apt.present
fi

echo "done. review with: git status"
