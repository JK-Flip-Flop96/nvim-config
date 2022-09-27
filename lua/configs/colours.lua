-- Set the catppuccin flavour
vim.g.catppuccin_flavour = "mocha"

-- Get the palette of the selected flavour
local mocha = require("catppuccin.palettes").get_palette("mocha")

-- Configuration of the catppuccin theme
require("catppuccin").setup {
	compile = {
		-- Compile the theme on startup
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},

	integrations = {
		lsp_trouble = true,
		treesitter = true,
		gitsigns = true,
		cmp = true,
	},

    highlight_overrides = {
		all = {},
		latte = {},
		frappe = {},
		macchiato = {},
		mocha = {
			TabLineFill = { fg = mocha.lavender, bg = mocha.mantle },
			TablineSel = { fg = mocha.subtext1, bg = mocha.surface1 },
			Tabline = { fg = mocha.overlay0, bg = mocha.surface0 },
			Comment = { fg = mocha.overlay1 },
			CursorLineNR = { fg = mocha.yellow },
		},
	},
}

-- Apply the catppuccin theme
vim.api.nvim_command "colorscheme catppuccin"
