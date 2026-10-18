#!/usr/bin/env bash
# frondier dotfiles — installs the configs from this repo into $HOME via symlinks.
# Safe to run repeatedly: existing paths that are not symlinks are NEVER overwritten.

set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() { # link <source-inside-repo> <destination>
    local src="$1" dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            echo "OK    $dst (already linked correctly)"
        elif [ -L "$dst" ]; then
            echo "SKIP  $dst -> $(readlink "$dst") (different symlink; inspect manually)"
        else
            echo "SKIP  $dst (real file/dir already exists; not overwritten)"
        fi
        return
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "LINK  $dst -> $src"
}

echo "== 1. Application configs (~/.config/*) =="
for d in "$DOTDIR"/.config/*; do
    [ -e "$d" ] || continue
    [ "$(basename "$d")" = "scripts" ] && continue   # linked directly below
    link "$d" "$HOME/.config/$(basename "$d")"
done
link "$DOTDIR/scripts" "$HOME/.config/scripts"

echo "== 2. Shell & GTK themes =="
[ -f "$DOTDIR/.zshrc" ] && link "$DOTDIR/.zshrc" "$HOME/.zshrc"
[ -d "$DOTDIR/.zsh" ]   && link "$DOTDIR/.zsh"   "$HOME/.zsh"
[ -d "$DOTDIR/.themes" ] && link "$DOTDIR/.themes" "$HOME/.themes"

echo "== 3. keyd (Super-tap remap) =="
if [ -f /etc/keyd/default.conf ]; then
    echo "OK    /etc/keyd/default.conf exists"
else
    echo "NOTE  copy system/keyd/default.conf -> /etc/keyd/default.conf (needs sudo),"
    echo "      then: sudo systemctl enable --now keyd"
fi

echo
echo "Done. Re-login (niri hot-reloads its config) to apply."
