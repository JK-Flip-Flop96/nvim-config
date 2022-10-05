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
		nvimtree = true,
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

			-- Mason Colours 
			MasonHeader = { fg = mocha.base, bg = mocha.peach },
			MasonHeaderSecondary = { fg = mocha.base, bg = mocha.teal },

			MasonHighlight = { fg = mocha.teal },
			MasonHighlightBlock = { bg = mocha.teal, fg = mocha.base },
			MasonHighlightBlockBold = { bg = mocha.teal, fg = mocha.base, bold = true },

			MasonHighlightSecondary = { fg = mocha.red },
			MasonHighlightBlockSecondary = { bg = mocha.red, fg = mocha.base },
			MasonHighlightBlockBoldSecondary = { bg = mocha.red, fg = mocha.base, bold = true },

			MasonLink = { fg = mocha.blue },

			MasonMuted = { fg = mocha.overlay2 },
			MasonMutedBlock = { bg = mocha.overlay2, fg = mocha.base },
			MasonMutedBlockBold = { bg = mocha.overlay2, fg = mocha.base, bold = true },

			MasonError = { fg = mocha.red },

			MasonHeading = { bold = true }

		},
	},
}

-- Apply the catppuccin theme
vim.api.nvim_command "colorscheme catppuccin"
