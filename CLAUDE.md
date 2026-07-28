# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for a NixOS + Hyprland setup, managed with GNU Stow. All unused configs are deleted from the repo — only actively used configs live here.

## Stow conventions

All stow commands must be run from `/home/fox/.dot/`. The `--dotfiles` flag is always required — it translates `dot-` directory prefixes to `.` when creating links (e.g. `dot-config/` → `.config/`).

```bash
stow --stow --dotfiles <package>      # link a package
stow --delete --dotfiles <package>    # unlink a package
stow --restow --dotfiles <package>    # re-link after adding files
```

Packages that use `dot-config/` map into `~/.config/`. The `alacritty` and `nano` packages use plain `.config/` (no dot-prefix translation needed).

## Adding a new config package

1. Create `<name>/dot-config/<app>/` (or `<name>/.config/<app>/` if the dir shouldn't be renamed)
2. Add files inside
3. Run `stow --stow --dotfiles <name>` from the repo root
4. Commit both the new files and any related changes together

## System packages

System packages are managed in `/etc/nixos/configuration.nix` (requires `sudo nixos-rebuild switch`). Stow only manages config files — installing new tools requires a NixOS rebuild.

## Hyprland config

`hyprland/dot-config/hypr/hyprland.lua` — written in Hyprland's Lua API (not the legacy `.conf` format). Key things to know:

- Autostart programs go in the `hl.on("hyprland.start", ...)` block at the top
- Keybindings use `hl.bind(...)` with `hl.dsp.*` dispatch helpers
- `SUPER + R` opens wofi (`wofi --show drun`)
- Cursor is applied via both `hl.env("XCURSOR_THEME", ...)` and `hyprctl setcursor` in autostart — both are needed; env alone doesn't take effect on reload

`hyprland/dot-config/hypr/hyprpaper.conf` — uses block syntax required by hyprpaper 0.8.4+. The old `preload =` / `wallpaper = monitor,path` format does **not** work in this version.

## Monitor setup

Three kanshi profiles in `kanshi/dot-config/kanshi/config`:
- `portable` — laptop display only (`eDP-1`)
- `docked` — external monitor only (`DP-2`, 1920×1080)
- `rokid` — Rokid AR glasses only

When adding wallpaper entries, all three monitor names must be covered: `eDP-1`, `DP-2`, and `PNP(LBT) Rokid Max Unknown`.

## Style conventions

Wofi and waybar share a consistent dark theme: background `#111117`, cyan accent `#33ccff`, green accent `#00ff99` (matching the Hyprland active border gradient). New UI configs should follow this palette.
