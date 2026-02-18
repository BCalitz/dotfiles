# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on [LazyVim](https://lazyvim.github.io/), a batteries-included Neovim distribution. The config is primarily focused on Angular/TypeScript development.

## Architecture

The entry point is `init.lua`, which bootstraps `lazy.nvim` (the plugin manager) via `lua/config/lazy.lua`. LazyVim then auto-loads all files under `lua/config/` and `lua/plugins/`.

**Load order:**
1. `lua/config/options.lua` — loaded before lazy.nvim starts
2. `lua/config/lazy.lua` — bootstraps lazy.nvim, imports LazyVim + extras + custom plugins
3. `lua/plugins/*.lua` — each file returns a lazy.nvim plugin spec; all are auto-imported
4. `lua/config/keymaps.lua` and `lua/config/autocmds.lua` — loaded on `VeryLazy` event

**Plugin configuration pattern:** Every file in `lua/plugins/` returns a table of lazy.nvim specs. To override a LazyVim default plugin, return a spec with the same plugin name and use `opts` (merged) or `opts = function(_, opts)` (extend). Never call `setup()` directly — lazy.nvim handles that.

**Extras managed by LazyVim UI (`lazyvim.json`):** These are toggled via `:LazyExtras` in Neovim and stored in `lazyvim.json`. Do not manually edit this file.

## Active Extras (from `lazyvim.json`)

- `ai.claudecode` + `ai.supermaven` — AI integrations
- `lang.angular` + `lang.typescript` — Angular/TS LSP (uses `vtsls` instead of `tsserver`)
- `lang.json` + `lang.markdown`
- `formatting.prettier` + `linting.eslint`
- `util.gh` + `util.mini-hipatterns`
- `vscode` — VS Code compatibility mode

## Custom Plugins (`lua/plugins/`)

| File | Purpose |
|------|---------|
| `lsp.lua` | Overrides `angularls` (disables semantic tokens) and `vtsls` (forces workspace TypeScript) |
| `extras.lua` | Treesitter parsers for Angular/HTML, `ng.nvim` for template↔component navigation, `tsc.nvim` for TypeScript watch |
| `colorscheme.lua` | Tokyonight with transparent background |
| `example.lua` | Template/reference file; returns `{}` and is never loaded |

## Key Custom Keymaps

Defined in `lua/config/keymaps.lua`:
- `<C-n>` / `<C-p>` (insert) — nvim-cmp navigation (opens menu if not visible)
- `<C-Space>` (insert) — force nvim-cmp menu

From `ng.nvim` (defined in `extras.lua`):
- `<leader>lt` — go to Angular template for component under cursor
- `<leader>lc` — go to component for current template file
- `<leader>aT` — show Angular template typecheck block

## Formatting

Lua files use **StyLua** with 2-space indentation and 120-column width (see `stylua.toml`). The `-- stylua: ignore` comment disables formatting for the next line/block.

## Making Changes

- **Add a plugin:** Create or edit a file in `lua/plugins/` returning a lazy.nvim spec.
- **Override a LazyVim plugin:** Use the same plugin name with `opts` in `lua/plugins/`.
- **Toggle a LazyVim extra:** Use `:LazyExtras` inside Neovim (updates `lazyvim.json`). For extras needed unconditionally in code (not the UI toggle), import them in `lua/config/lazy.lua` `spec` array.
- **Update plugins:** Run `:Lazy update` inside Neovim; updates `lazy-lock.json`.
- **Check health:** Run `:checkhealth` inside Neovim.
