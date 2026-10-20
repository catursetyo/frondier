# frondier

Personal dotfiles for **Fedora 44** using **niri + Noctalia**.

## Architecture

Everything is linked into `$HOME` via symlinks: `~/.config/<app> -> repo/.config/<app>`.
niri hot-reloads — edit and save, done.

Three moving parts:

1. **niri** — scrollable-tiling compositor. Its config (`~/.config/niri/config.kdl`) is
   **generated**: the source of truth is the Noctalia template
   (`.config/noctalia/templates/niri-config.kdl`). Edit the template, then render:
   ```bash
   noctalia theme <wallpaper-image> -r "$HOME/.config/noctalia/templates/niri-config.kdl:$HOME/.config/niri/config.kdl"
   ```
2. **Noctalia** — the shell (bar, launcher, control center, notifications, wallpaper,
   lock screen, clipboard panel). Config: plain TOML in `.config/noctalia/*.toml`,
   hot-reloaded. Palette is derived from the wallpaper (`theme.source = "wallpaper"`),
   so the whole look follows every wallpaper change.
3. **keyd** — system-level remap: a Super **tap** emits ScrollLock (bound to the app
   launcher in niri), a **hold** stays a normal Super. Config archived in `system/keyd/`.

## Dependencies

**Easiest path: `./setup.sh`** — installs everything below (idempotent, safe to re-run),
handles copr/source-build fallbacks, sets up keyd, then hands off to `./install.sh`.

| Package | Source | Role |
|---|---|---|
| `niri` | Fedora 44 repos | compositor |
| `noctalia` (5.3+) | Fedora 44 official repo | desktop shell (bar, launcher, panels, wallpaper, lock) |
| `keyd` | copr `alternateved/keyd` (source-build fallback) | Super-tap remap (`/etc/keyd/default.conf`) |
| `mpvpaper` | copr `solopasha/hyprland` (source-build fallback) | video wallpaper (noctalia/mpvpaper plugin) |
| `polkit-kde` | Fedora repos | polkit auth dialogs (auto-starts via XDG autostart) |
| `wallust` | Fedora repos | kitty/zathura/rmpc colors (run manually) |
| Iosevka Nerd Font | GitHub release (auto-downloaded by setup.sh) | terminal & bar font |

Apps matching the configs (also installed by setup.sh): `thunar starship yazi btop
fastfetch nvim newsboat zathura mpv grim slurp swappy wl-clipboard imagemagick`.

Session-level plumbing (env import, portals, XDG autostart) is handled by
`niri-session` + the packaged `niri-portals.conf` — nothing to configure.

## Usage

```bash
git clone https://github.com/catursetyo/frondier.git
cd frondier
./setup.sh
```

## References

[Kitty config file](https://github.com/NischalDawadi/Hyprlust)
