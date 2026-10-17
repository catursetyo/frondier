#!/usr/bin/env bash
# frondier dotfiles — installs the configs from this repo into $HOME via symlinks.
# Safe to run repeatedly: existing paths that are not symlinks are NEVER overwritten.
#
# Prerequisite: JaKooLit Hyprland-Dots must be installed for parts 3 & 4
# (see README, "Dependencies").

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
    link "$d" "$HOME/.config/$(basename "$d")"
done

echo "== 2. Shell & GTK themes =="
[ -f "$DOTDIR/.zshrc" ] && link "$DOTDIR/.zshrc" "$HOME/.zshrc"
[ -d "$DOTDIR/.zsh" ]   && link "$DOTDIR/.zsh"   "$HOME/.zsh"
[ -d "$DOTDIR/.themes" ] && link "$DOTDIR/.themes" "$HOME/.themes"

echo "== 3. Personal Hyprland overlay =="
if [ -d "$HOME/.config/hypr" ]; then
    for d in UserConfigs UserScripts; do
        if [ -d "$DOTDIR/hypr-user/$d" ]; then
            if [ -d "$HOME/.config/hypr/$d" ] && [ ! -L "$HOME/.config/hypr/$d" ]; then
                cp -a "$DOTDIR/hypr-user/$d/." "$HOME/.config/hypr/$d/"
                echo "COPY  hypr-user/$d/* -> ~/.config/hypr/$d/ (overwrites JaKooLit defaults)"
            else
                link "$DOTDIR/hypr-user/$d" "$HOME/.config/hypr/$d"
            fi
        fi
    done
    echo "NOTE  hypr-user/monitors.conf is hardware-specific — adjust it before use"
else
    echo "NOTE  ~/.config/hypr does not exist yet — install JaKooLit Hyprland-Dots first (README: Dependencies)"
fi

echo "== 4. Waybar theme selection (JaKooLit) =="
if [ -d "$HOME/.config/waybar/configs" ]; then
    link "$HOME/.config/waybar/configs/[TOP] Default Laptop" "$HOME/.config/waybar/config"
    link "$HOME/.config/waybar/style/[Dark] Purpl.css" "$HOME/.config/waybar/style.css"
else
    echo "NOTE  JaKooLit waybar not found — skipping"
fi

echo
echo "Done. Re-login (or run 'hyprctl reload') to apply."
