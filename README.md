# frondier

Personal dotfiles for **Fedora 43 + Hyprland (Wayland)** on the machine `fedorawr`.

## Architecture

This setup works in two layers:

1. **Personal layer (this repo)** — application configs linked into `$HOME` via symlinks
   (Hyprlust style): `~/.config/<app> -> repo/.config/<app>`, plus `.zshrc`, `.zsh/`, `.themes/`.
   Hyprland caches its config at startup, so a broken symlink isn't immediately visible —
   if something suddenly "falls back to the default look", check: `find ~/.config -maxdepth 1 -xtype l`.
2. **Base layer [JaKooLit](https://github.com/JaKooLit/Hyprland-Dots)** — a *dependency*, not
   vendored here (see Dependencies). The personal overlay lives in `hypr-user/`.

## Structure

```
frondier/
├── README.md            # this file
├── UPSTREAM.md          # original Hyprlust README (upstream attribution)
├── install.sh           # symlink installer (safe to run repeatedly)
├── hypr-user/           # personal Hyprland overlay: UserConfigs/, UserScripts/, monitors.conf
├── .config/             # application configs (symlinked into ~/.config)
│   ├── rofi/            #   master config + per-purpose configs (emoji, beats, wallpaper, ...)
│   ├── swaync/          #   notifications + panel (Super+Shift+N)
│   ├── wlogout/ gtk-*/ qt5ct/ qt6ct/ Kvantum/   # theming & toolkits
│   ├── nvim/ btop/ fastfetch/ mpv/ newsboat/ zathura/ yazi/ ...
│   ├── matugen/ wallust/ #   wallpaper-driven color scheme generators
│   ├── spicetify/ streamrip/ rmpc/ mpDris2/ mpd/ # media
│   ├── Seanime/ smassh/ sptlrx/ swappy/ trakt-scrobbler/ Upscayl/ ...
│   └── starship.toml    # prompt
├── .zshrc               # shell (sources plugins from .zsh/)
├── .zsh/                # zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions
└── .themes/             # GTK themes (adw-gtk3, Colloid-Dark, Graphite-Dark)
```

## Dependencies

The following are intentionally **not** part of this repo and must be installed separately:

### JaKooLit Hyprland-Dots (v2.3.18)

The foundation of the entire Hyprland & waybar setup. It provides:

- `~/.config/hypr/` — `hyprland.conf`, keybinds, window rules, animations, scripts
  (`~/.config/hypr/scripts/`), and the `UserConfigs/` & `UserScripts/` structure for user overlays.
- `~/.config/waybar/` — waybar modules, themes, and layouts.
- `~/.config/kitty/` + `~/.config/cava/` — both are *wallust templates* (their colors are
  regenerated automatically from the wallpaper; no need to keep them in a repo).

Install using the official installer:

```bash
git clone --depth 1 https://github.com/JaKooLit/Hyprland-Dots.git
cd Hyprland-Dots && ./install.sh   # pick the preset that fits you
```

Afterwards, run `./install.sh` from this repo — the `hypr-user/` overlay overwrites the
JaKooLit defaults (or gets symlinked if not present yet).

### JaKooLit rofi themes

The `KooL_style-*` themes (including `KooL_LonerOrZ`) live outside this repo:

```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/JaKooLit/Hyprland-Dots /tmp/jakoolit
git -C /tmp/jakoolit sparse-checkout set config/rofi
cp /tmp/jakoolit/config/rofi/themes/*.rasi ~/.local/share/rofi/themes/
```

### Fedora packages

```bash
sudo dnf install hyprland waybar rofi swaync swww cliphist pyprland hypridle hyprlock \
  wlogout kitty wallust nm-applet iio-hyprland wl-clipboard grim slurp swappy \
  imagemagick starship yazi mpv cava thunar
```

Fonts: **Inter** (used by rofi) and a **Nerd Font** for icons.

## Usage

```bash
git clone <this-repo-url> ~/programs/linux/frondier   # any location works
cd ~/programs/linux/frondier
./install.sh
# re-login, or: hyprctl reload
```

`install.sh` never overwrites existing real files/directories — those are reported as `SKIP`.

## Notes

- **rofi 2.0.0** (native Wayland, replaces `rofi-wayland`): the `-modi` flag still works,
  though the official docs now use `-modes`.
- **ags is disabled** (not installed on this system): the `Super+A` keybind and the ags lines
  in `Startup_Apps.conf` / `Refresh.sh` are commented out — uncomment them if ags is installed again.
- `hypr-user/monitors.conf` is **hardware-specific** — adjust it per machine.
- `.config/rofi/.current_wallpaper` is generated automatically by the wallpaper scripts (gitignored).
- Runtime parts excluded from the repo (gitignored): `spicetify/Backup` & `spicetify/Extracted`
  (regenerate with `spicetify backup apply`), `mpv/scripts/uosc/bin` (reinstall via the uosc installer).
- On the original machine the live configs were referenced through `~/Hyprlust`; this repo's
  `install.sh` uses the repo itself as the symlink source, so it no longer depends on the upstream clone.

## To-do (repo owner)

- [ ] `git init` + add a remote, first push (done manually by the owner).
- [ ] Clean up the leftover `/home/hypr/...` PATH entries from an old machine in `.zshrc`.
