-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- PowerLine arrow symbols
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config = {
	automatically_reload_config = true,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Nord (Gogh)",
	default_prog = {
		"C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe",
	},
	--font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 12.5,
	background = {
		{
			source = {
				File = "C:/Users/Brandon/Pictures/pexels-eberhardgross-691668.jpg",
			},
			hsb = {
				hue = 1.0,
				saturation = 1.02,
				brightness = 0.25,
			},
			width = "100%",
			height = "100%",
		},
		{
			source = {
				Color = "#282c35",
			},
			width = "100%",
			height = "100%",
			opacity = 0.8,
		},
	},
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

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 50
config.tab_and_split_indices_are_zero_based = false

local RIGHT_BORDER = ""

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	-- local edge_background = "#2a2a40"
	local background = "#1a1b26"
	local foreground = "#c0caf5"
	local edge_foreground = background

	if tab.is_active then
		background = "#7aa2f7"
		foreground = "#e3e5e5"
	elseif hover then
		background = "#1b1b32"
		foreground = "#909090"
	end

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		-- Right border
		{ Background = { Color = tab.is_active and "#7aa2f7" or "#1a1b26" } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = (tab.is_active and tab.tab_index ~= 0) and RIGHT_BORDER or " " },

		-- Tab title
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },

		-- Right border
		{ Foreground = { Color = tab.is_active and "#7aa2f7" or "#c0caf5" } },
		{ Text = tab.is_active and RIGHT_BORDER or " " },

		-- If you want, add more stuff to the tab bar.
	}
end)

-- Finally, return the configuration to wezterm:
return config
