-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Tokyo Night",
	default_prog = {
		"C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe",
	},
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 12.5,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.5,
	},
	-- Tab bar
	enable_tab_bar = true,
	tab_bar_at_bottom = false,
	use_fancy_tab_bar = true,
	tab_max_width = 50,
	window_frame = {
		active_titlebar_bg = "#1a1b26",
		inactive_titlebar_bg = "#1a1b26",
	},
	-- Keys
	keys = {
		-- Split panes
		{ key = "=", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Navigate panes with arrow keys
		{ key = "LeftArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Down") },

		-- Vim-style navigation
		{ key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Down") },

		-- Close pane
		{ key = "w", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		-- Zoom pane
		{ key = "z", mods = "CTRL|ALT", action = wezterm.action.TogglePaneZoomState },
	},
}

-- Use pane title as tab title (set by shells/programs via escape sequences)
wezterm.on("format-tab-title", function(tab)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	return " " .. title .. " "
end)

-- Finally, return the configuration to wezterm:
return config
