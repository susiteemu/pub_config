local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
--config.font = wezterm.font("VictorMono Nerd Font", { weight = 'DemiBold' })
config.font = wezterm.font("Hack FC Ligatured CCG", { weight = "Regular" })

config.font_size = 16.0
--config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.colors = {
	tab_bar = {
		background = "#313244",
		active_tab = {
			fg_color = "#bac2de",
			bg_color = "#313244",
		},
		inactive_tab = {
			bg_color = "#313244",
			fg_color = "#bac2de",
		},
		inactive_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#bac2de",
		},
		new_tab = {
			bg_color = "#313244",
			fg_color = "#cdd6f4",
		},
		new_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
		},
	},
}

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.window_decorations = "RESIZE"

config.window_frame = {
	active_titlebar_bg = "#313244",
	inactive_titlebar_bg = "#313244",
	font_size = 19,
	font = wezterm.font("Hack FC Ligatured CCG", { weight = "Bold" }),
}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		if tab_info.is_active then
			return string.format("[%d]: %s", tab_info.tab_index + 1, title)
		else
			return string.format("%d: %s", tab_info.tab_index + 1, title)
		end
	end
	local process_name = tab_info.active_pane.foreground_process_name
	if process_name and #process_name > 0 then
		if tab_info.is_active then
			return string.format("[%d]: %s", tab_info.tab_index + 1, basename(process_name))
		else
			return string.format("%d: %s", tab_info.tab_index + 1, basename(process_name))
		end
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	if tab_info.is_active then
		return tab_info.active_pane.title
	else
		return tab_info.active_pane.title
	end
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = tab_title(tab)
	return title
end)

config.mouse_bindings = {
	-- Disable the default click behavior
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	-- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
}

config.keys = {
	{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "Enter", mods = "CMD", action = act.ActivateCopyMode },
	{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
	{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
	{
		key = "U",
		mods = "SHIFT|CTRL",
		action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
	},
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
	{ key = "LeftArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "D", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CMD", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD", action = act.ActivatePaneDirection("Right") },
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "t", mods = "CMD|SHIFT", action = act.ShowTabNavigator },
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "x", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "b", mods = "LEADER|CTRL", action = act.SendString("\x02") },
	{ key = "Enter", mods = "LEADER", action = act.ActivateCopyMode },
	{
		key = "k",
		mods = "CMD",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	{
		key = "R",
		mods = "CMD|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "T",
		mods = "CMD|SHIFT",
		action = act.PromptInputLine({
			description = "Enter name for theme",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					local overrides = window:get_config_overrides() or {}
					if not overrides.color_scheme then
						overrides.color_scheme = line
					else
						overrides.color_scheme = nil
					end
					window:set_config_overrides(overrides)
				end
			end),
		}),
	},
	{
		key = ",",
		mods = "CMD",
		action = act.SpawnCommandInNewTab({
			cwd = os.getenv("WEZTERM_CONFIG_DIR"),
			set_environment_variables = {
				TERM = "screen-256color",
			},
			args = {
				"/opt/homebrew/bin/nvim",
				os.getenv("WEZTERM_CONFIG_FILE"),
			},
		}),
	},
}

config.skip_close_confirmation_for_processes_named = {}

for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return config
