# frondier

Personal dotfiles for **Fedora 43** on the machine `fedorawr`.
Desktop session: **niri + Noctalia**.

## Architecture

Everything is linked into `$HOME` via symlinks: `~/.config/<app> -> repo/.config/<app>`.
Hyprland caches its config at startup, but niri hot-reloads — edit and save, done.

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

| Package | Source | Role |
|---|---|---|
| `niri` 26.04+ | Fedora updates | compositor |
| `noctalia-shell-v5` | copr `pm4rcin/Hyprland` (fc43 build) or official repo (F44+) | desktop shell |
| `keyd` | copr `alternateved/keyd` | Super-tap remap (`/etc/keyd/default.conf`) |
| `polkit-kde` | Fedora repos | polkit auth dialogs (auto-starts via XDG autostart) |
| `wallust` | Fedora repos | kitty/zathura/rmpc colors (run manually) |

Fonts: **Inter** and a **Nerd Font**.

Session-level plumbing (env import, portals, XDG autostart) is handled by
`niri-session` + the packaged `niri-portals.conf` — nothing to configure.

## Usage

```bash
git clone https://github.com/catursetyo/frondier.git
cd frondier
./install.sh
```
