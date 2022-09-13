-- Set the catppuccin flavour
vim.g.catppuccin_flavour = "mocha"

-- Get the palette of the selected flavour
local colors = require("catppuccin.palettes").get_palette()

-- Configuration of the catppuccin theme
require("catppuccin").setup({
	integrations = {
		lsp_trouble = true,
	},
    custom_highlights = {
		-- Colours to be used by the tab line
		TablineFill = { bg = colors.mantle },
		TablineSel = { fg = colors.subtext1, bg = colors.surface1 },
	}
})

-- Apply the catppuccin theme
vim.cmd("colorscheme catppuccin")
