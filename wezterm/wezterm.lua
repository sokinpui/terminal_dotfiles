local wezterm = require 'wezterm'
local config = {
}

-- appearance
-- config.color_scheme = 'DoomOne'
config.hide_mouse_cursor_when_typing = true
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

local DoomOne = wezterm.color.get_builtin_schemes()['DoomOne']
DoomOne.cursor_bg = "#bbc2cf"
config.color_schemes = {
  ['DoomOne'] = DoomOne,
}
config.color_scheme = 'DoomOne'


-- cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 700

-- window
config.window_decorations = "RESIZE"
config.window_close_confirmation = 'NeverPrompt'
config.initial_rows = 40
config.initial_cols = 80

-- font
config.font = wezterm.font('JetBrains Mono', { weight = 'SemiBold'})
config.font_size = 12.0
config.font_rules = {
  -- For Bold-but-not-italic text, use this relatively bold font, and override
  -- its color to a tomato-red color to make bold text really stand out.
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font({
      family = 'JetBrains Mono',
      weight = 'ExtraBold',
    }),
  },

  -- Bold-and-italic
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font({
      family = 'JetBrains Mono',
      weight = 'ExtraBold',
      italic = true,
    }),
  },

  -- normal-intensity-and-italic
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font({
      family = 'JetBrains Mono',
      weight = 'Bold',
      italic = true,
    }),
  },
}
config.line_height = 0.8

-- startup program
config.default_prog = { '/usr/bin/zsh', '--login', '-c', 'tmux attach || tmux'}

-- keyboard
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- bell
config.audible_bell = "Disabled"

-- utilities
config.automatically_reload_config = true

-- key mapping
config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment, },
}

return config
