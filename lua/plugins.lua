vim.cmd[[packadd packer.nvim]]

-- Intialise Packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Use Packer in a pop up
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "none" }
		end,
	},
	auto_reload_compiled = true,
}

-- Install Plugins
return packer.startup(function()

	-- Package Manager
	use 'wbthomason/packer.nvim'

	-- Startup performance enhancement
	use {
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end
	}

	-- Icons used by many other plugins
	use 'kyazdani42/nvim-web-devicons'

	-- File Tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
	}

	-- Floating terminal windows
	use {"akinsho/toggleterm.nvim", config = function()
		require("toggleterm").setup()
	end}

	-- Custom Status Line
	use "rebelot/heirline.nvim"

	-- Tree Sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- Startup Screen
	use 'goolord/alpha-nvim'

	-- Git Icons
	use {
	    'lewis6991/gitsigns.nvim',
	    config = function()
	        require('gitsigns').setup()
	    end
	}

	-- Completions
	use "williamboman/mason.nvim" -- Installer for LSPs
	use "williamboman/mason-lspconfig.nvim" -- Bridge between Mason and LSPs
	use "neovim/nvim-lspconfig" -- LSP configs for Nvim

	-- navigation
	use "SmiteshP/nvim-navic" -- Can show the LSP context in the status bar

	-- Completion Sources
	use "hrsh7th/cmp-nvim-lsp" -- Completions from LSPs
	use "hrsh7th/cmp-buffer" -- Completions for words in the buffer
	use "hrsh7th/cmp-path" -- Completions for filesystem paths
	use "hrsh7th/cmp-cmdline" -- Completions for vim's command line
	use "octaltree/cmp-look" -- Look-based word lookupp
	use "petertriho/cmp-git" -- Completions for Git
	use "hrsh7th/nvim-cmp" -- Completions plugin

	-- LuaSnip
	use "L3MON4D3/LuaSnip" -- Snippet Loader
	use "saadparwaiz1/cmp_luasnip" -- Cmp/LuaSnip Compatability
	use "rafamadriz/friendly-snippets" -- Snippets

	-- GitHub Co-Pilot
	--use "github/copilot.vim" -- Main Co-Pilot Plugin - Only enable if you want to configure the Co-Pilot Plugin
	use {
	    "zbirenbaum/copilot.lua", -- Pure lua replacement for copilot.vim
		event = { "VimEnter" },
	    config = function ()
	    	vim.defer_fn(function () -- Defer loading Copilot until nvim has already started
	    	    require("copilot").setup()
	    	end, 100)
	    end,
	}

	use {
		"zbirenbaum/copilot-cmp",-- Adds copilot as a Completions source
		after = { "copilot.lua" },
		config = function ()
			require("copilot_cmp").setup()
		end,
	}

	-- LSP Diagnostic Information printed on seperate lines
	use({
	    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	    config = function ()
	    	require("lsp_lines").setup()
	    end
	})

	-- Diagnostics Popout 
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function ()
			require("trouble").setup()
		end,
	}

	-- Shortcut helper
	use {
		"folke/which-key.nvim",
		config = function ()
			require("which-key").setup()
		end,
	}

	-- Highlighting and listing for Todo comments
	use {
		"folke/todo-comments.nvim",
		config = function ()
			require("todo-comments").setup()
		end,
	}

	-- Indent markers
	use "lukas-reineke/indent-blankline.nvim"

	-- Smooth Scrolling
	use 'karb94/neoscroll.nvim'

	-- Libraries
    use 'nvim-lua/plenary.nvim'
	use 'yegappan/mru'

	-- UI Libraries
	use 'MunifTanjim/nui.nvim'
	use 'rcarriga/nvim-notify'

	use ({
		'folke/noice.nvim',
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})

	use {
		"nvim-telescope/telescope.nvim",
		branch = '0.1.x',
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}

	use {
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}

	use 'alexghergh/nvim-tmux-navigation'

	-- Colour Scheme
	use {
        "catppuccin/nvim",
		as = "catppuccin",
		run = ":CatppuccinCompile"
	}

	-- Colour code highlighting 
	use{
	    'norcalli/nvim-colorizer.lua',
	    config = function()
			require('colorizer').setup()
	    end
	}

end)
