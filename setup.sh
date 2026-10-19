#!/usr/bin/env bash
# frondier — dependency bootstrap for a fresh Fedora 44
# Installs everything the session needs, then hands off to ./install.sh
# for the dotfiles themselves. Safe to re-run: every step is idempotent.

set -uo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

section() { echo; echo "━━ $* ━━"; }

have() { command -v "$1" >/dev/null 2>&1; }

section "1. Core session (official Fedora repos)"
sudo dnf install -y niri noctalia polkit-kde kitty wallust wlogout mpv \
     thunar starship yazi btop fastfetch nvim newsboat zathura eza zoxide fzf \
     grim slurp swappy wl-clipboard imagemagick

section "2. Fonts: Iosevka Nerd Font (terminal & bar)"
if fc-list 2>/dev/null | grep -qi "iosevka nerd"; then
    echo "OK    already installed"
else
    mkdir -p ~/.local/share/fonts
    curl -fL --progress-bar \
        -o /tmp/Iosevka.tar.xz \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.tar.xz"
    tar -xf /tmp/Iosevka.tar.xz -C ~/.local/share/fonts
    fc-cache -f ~/.local/share/fonts >/dev/null
    echo "OK    Iosevka Nerd Font installed"
fi

section "3. keyd (Super-tap remap) — copr alternateved/keyd"
if have keyd; then
    echo "OK    keyd already installed"
else
    sudo dnf copr enable -y alternateved/keyd 2>/dev/null \
        || echo "WARN  copr unavailable — falling back to source build"
    if sudo dnf install -y keyd 2>/dev/null; then
        echo "OK    keyd installed"
    else
        echo ">>    building keyd from source"
        sudo dnf install -y git cmake gcc ninja-build 2>/dev/null || true
        rm -rf /tmp/keyd-src
        git clone --depth 1 https://github.com/rvaiya/keyd /tmp/keyd-src
        (cd /tmp/keyd-src && ./configure && make -j"$(nproc)" && sudo make install)
    fi
    [ -f /etc/keyd/default.conf ] || {
        sudo mkdir -p /etc/keyd
        sudo cp "$DOTDIR/system/keyd/default.conf" /etc/keyd/default.conf
    }
    sudo systemctl enable --now keyd 2>/dev/null
    echo "OK    keyd configured (Super-tap → ScrollLock → launcher)"
fi

section "4. mpvpaper (video wallpaper) — copr solopasha/hyprland or source"
if have mpvpaper; then
    echo "OK    mpvpaper already installed"
else
    sudo dnf copr enable -y solopasha/hyprland 2>/dev/null || true
    if sudo dnf install -y mpvpaper 2>/dev/null; then
        echo "OK    mpvpaper installed (copr)"
    else
        echo ">>    copr has no chroot for this release — building from source"
        sudo dnf install -y mpv-devel wayland-devel wayland-protocols-devel \
             meson ninja-build gcc 2>/dev/null || true
        rm -rf /tmp/mpvpaper-src
        git clone --depth 1 https://github.com/GhostNaN/mpvpaper /tmp/mpvpaper-src
        (cd /tmp/mpvpaper-src \
            && meson setup build --prefix /usr/local \
            && ninja -C build && sudo ninja -C build install)
        echo "OK    mpvpaper installed (source)"
    fi
fi

section "5. Dotfiles (symlinks into \$HOME)"
"$DOTDIR/install.sh"

section "6. Post-install notes"
cat <<'NOTES'
- Re-login to start the niri + Noctalia session.
- Noctalia: Settings → Plugins → confirm "sticky-notes" is enabled
  (config in .config/noctalia/plugins.toml already enables it).
- Calendar: paste your MyITS ICS URL into .config/noctalia/bar.toml
  (server_url — the token is personal, never commit it).
- keyd: Super tap = launcher, hold = normal Super.
NOTES
