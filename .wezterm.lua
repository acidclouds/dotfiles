-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
-- config.allow_square_glyphs_to_overflow_width = "Always"
config.warn_about_missing_glyphs = false
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font Propo Med",
	"IosevkaTerm Nerd Font Mono",
	"Symbols Nerd Font Mono",
})
-- config.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }
config.harfbuzz_features = {
	"ss01",
	"ss02",
	"ss03",
	"ss04",
	"ss05",
	"ss06",
	"ss07",
	"ss08",
	"ss09",
	"ss10",
	-- "cv01",
	-- "cv02",
	"cv04",
	-- "cv07",
	"cv14",
	"cv15",
	-- "cv17",
	"cv18",
	"cv24",
	"cv25",
	"cv26",
	-- "cv27",
	"cv28",
	-- "cv29",
	"cv30",
	-- "cv31",
	"cv32",
	-- "zero",
}
config.font_size = 14
config.enable_tab_bar = false
return config
