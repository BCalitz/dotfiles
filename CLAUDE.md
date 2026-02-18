# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for a Windows 11 machine, storing configuration for several tools under `~/.config/`. The primary theme across tools is **Nord** with Nerd Font icons.

## Repository Structure

| Path | What it configures |
|------|--------------------|
| `nvim/` | Neovim (LazyVim-based) — has its own `CLAUDE.md` with detailed architecture |
| `wezterm/wezterm.lua` | WezTerm terminal emulator |
| `starship.toml` | Starship prompt |
| `gh/config.yml` | GitHub CLI (`gh`) |
| `scoop/config.json` | Scoop package manager (gitignored — managed by scoop itself) |

## Key Conventions

- **Color theme:** Nord palette everywhere (WezTerm uses "Nord (Gogh)", Starship defines a `[palettes.nord]`, Neovim uses Tokyonight with transparent background).
- **Font:** Nerd Font icons are used throughout (Starship symbols, WezTerm tab bar). WezTerm font size is 12.5.
- **Shell:** Default shell in WezTerm is PowerShell (`C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe`).
- **Lua formatting:** Neovim Lua files use StyLua with 2-space indent and 120-column width (`nvim/stylua.toml`). WezTerm uses tabs.

## Git / Sensitive Files

The `.gitignore` excludes `gh/hosts.yml` (credentials), `scoop/` (auto-managed), `.claude/` (local settings), and the Windows-reserved `nul` file. Do not commit credentials or auto-managed config.

## Neovim Details

See [nvim/CLAUDE.md](nvim/CLAUDE.md) for full Neovim architecture, plugin system, keymaps, and how to make changes. In brief: it's a LazyVim setup with Angular/TypeScript extras, AI integrations (Claude Code + Supermaven), and custom LSP overrides.

## WezTerm Details

`wezterm/wezterm.lua` configures a background image with dark overlay, bottom tab bar with custom PowerLine-style formatting, and pane management keybindings (all use `Ctrl+Alt` modifier — splits, navigation, close, zoom).
