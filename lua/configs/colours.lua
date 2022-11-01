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
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.70,
	},
	integrations = {
		lsp_trouble = true,
		treesitter = true,
		gitsigns = true,
		cmp = true,
		nvimtree = true,
		telescope = true,
		which_key = true,
		dap = {
			enabled = true,
			enable_ui = true,
		},
		noice = true,
	},

    highlight_overrides = {
		all = {},
		latte = {},
		frappe = {},
		macchiato = {},
		mocha = {
			-- Neovim Colours
			-- Tabline 
			TabLineFill = { fg = mocha.lavender, bg = mocha.base },
			TabLineSel = { fg = mocha.subtext1, bg = mocha.surface1 },
			TabLine = { fg = mocha.overlay0, bg = mocha.surface0 },

			-- Editor
			Comment = { fg = mocha.overlay1 },
			CursorLineNR = { fg = mocha.yellow },

			-- Splits
			VertSplit = { fg = mocha.surface0 },

			-- Floats
			FloatNormal = { fg = mocha.text, bg = mocha.mantle },
			FloatBorder = { fg = mocha.surface2 },

			-- Noice			
			NoiceCmdlineIcon = { fg = mocha.peach },
			NoiceCmdlineIconCmdline = { fg = mocha.peach },

			NoiceCmdlinePopupBorder = { fg = mocha.surface2 },
			NoiceCmdlinePopupBorderCmdline = { fg = mocha.surface2 },
			NoiceCmdlinePopupBorderSearch = { fg = mocha.surface2 },
			NoiceCmdlinePopupBorderFilter = { fg = mocha.surface2 },
			NoiceCmdlinePopupBorderlua = { fg = mocha.surface2 },

			-- Mason Colours 
			MasonHeader = { fg = mocha.base, bg = mocha.peach },
			MasonHeaderSecondary = { fg = mocha.base, bg = mocha.teal },

			MasonHighlight = { fg = mocha.teal },
			MasonHighlightBlock = { bg = mocha.teal, fg = mocha.base },
			MasonHighlightBlockBold = { bg = mocha.teal, fg = mocha.base, bold = true },

			MasonHighlightSecondary = { fg = mocha.red },
			MasonHighlightBlockSecondary = { bg = mocha.red, fg = mocha.base },
			MasonHighlightBlockBoldSecondary = { bg = mocha.red, fg = mocha.base, bold = true },

			MasonLink = { fg = mocha.rosewater },

			MasonMuted = { fg = mocha.overlay1 },
			MasonMutedBlock = { bg = mocha.surface0, fg = mocha.overlay1 },
			MasonMutedBlockBold = { bg = mocha.surface0, fg = mocha.overlay1, bold = true },

			MasonError = { fg = mocha.red },

			MasonHeading = { bold = true },

			-- Alpha Colours
			AlphaHeader = { fg = mocha.surface0 },
			AlphaFooter = { fg = mocha.surface2 },
			AlphaSectionHeader = { fg = mocha.surface2, bold = true },
			AlphaShortcut = { fg = mocha.surface2 },

			--Telescope Colours
			TelescopeNormal = { fg = mocha.text, bg = mocha.mantle },
			TelescopeBorder = { fg = mocha.surface2 },
			TelescopeTitle = { fg = mocha.subtext0 },

			--ToggleTerm Custom Colours
			LazygitBorder = { fg = mocha.surface2 },

			--Nvim-Notify Colours
			NotifyERRORBorder = { fg = mocha.surface2, bg = mocha.mantle },
			NotifyWARNBorder = { fg = mocha.surface2, bg = mocha.mantle },
			NotifyINFOBorder = { fg = mocha.surface2, bg = mocha.mantle },
			NotifyDEBUGBorder = { fg = mocha.surface2, bg = mocha.mantle },
			NotifyTRACEBorder = { fg = mocha.surface2, bg = mocha.mantle },

			NotifyERRORIcon = { fg = mocha.red, bg = mocha.mantle },
			NotifyWARNIcon = { fg = mocha.yellow, bg = mocha.mantle },
			NotifyINFOIcon = { fg = mocha.green, bg = mocha.mantle },
			NotifyDEBUGIcon = { fg = mocha.surface2, bg = mocha.mantle },
			NotifyTRACEIcon = { fg = mocha.lavender, bg = mocha.mantle },

			NotifyERRORTitle = { fg = mocha.red, bg = mocha.mantle },
			NotifyWARNTitle = { fg = mocha.yellow, bg = mocha.mantle },
			NotifyINFOTitle = { fg = mocha.green, bg = mocha.mantle },
			NotifyDEBUGTitle = { fg = mocha.surface2, bg = mocha.mantle },
			NotifyTRACETitle = { fg = mocha.lavender, bg = mocha.mantle },

			NotifyERRORBody = { fg = mocha.text, bg = mocha.mantle },
			NotifyWARNBody = { fg = mocha.text, bg = mocha.mantle },
			NotifyINFOBody = { fg = mocha.text, bg = mocha.mantle },
			NotifyDEBUGBody = { fg = mocha.text, bg = mocha.mantle },
			NotifyTRACEBody = { fg = mocha.text, bg = mocha.mantle },
		},
	},
}

-- Apply the catppuccin theme
vim.api.nvim_command "colorscheme catppuccin"
