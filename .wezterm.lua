-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
-- config.allow_square_glyphs_to_overflow_width = "Always"
config.warn_about_missing_glyphs = false
config.font = wezterm.font_with_fallback({ "IosevkaTerm Nerd Font Mono" })
config.font_size = 14
config.enable_tab_bar = false
config.unicode_version = 13
return config
