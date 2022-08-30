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
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install Plugins
return packer.startup(function()
	-- Package Manager
	use 'wbthomason/packer.nvim'

        -- Floating terminal windows
	use {"akinsho/toggleterm.nvim", config = function()
                require("toggleterm").setup()
	end}

	-- Custom Status Line
	use "rebelot/heirline.nvim"

	-- Tab Bar
	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}

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

	-- Startup performance "enhancement
	use "lewis6991/impatient.nvim"

	-- Completions
	use "neovim/nvim-lspconfig" -- LSP configs for Nvim
	use "williamboman/mason.nvim" -- Installer for LSPs

	-- Completion Sources
	use "hrsh7th/cmp-nvim-lsp" -- Completions from LSPs
	use "hrsh7th/cmp-buffer" -- Completions for words in the buffer
	use "hrsh7th/cmp-path" -- Completions for filesystem paths
	use "hrsh7th/cmp-cmdline" -- Completions for vim's command line
	use "octaltree/cmp-look" -- Look-based word lookupp
	use "petertriho/cmp-git" -- Completions for Git
	use "hrsh7th/nvim-cmp" -- Completions plugin

	-- LuaSnip
	use "L3MON4D3/LuaSnip" -- Snippets
	use "saadparwaiz1/cmp_luasnip" -- Cmp/LuaSnip Compatability

	-- GitHub Co-Pilot
	--use "github/copilot.vim" -- Main Co-Pilot Plugin - Only enable if you want to configure the Co-Pilot Plugin
	use {
	    "zbirenbaum/copilot.lua", -- Pure lua replacement for copilot.vim
	    event = {"VimEnter"},
	    config = function ()
	    	vim.defer_fn(function () -- Defer loading Copilot until nvim has already started
	    	    require("copilot").setup()
	    	end, 100)
	    end,
	}
	use "zbirenbaum/copilot-cmp" -- Adds copilot as a Completions source

	-- LSP Diagnostic Information printed on seperate lines
	use({
	    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	    config = function ()
	    	require("lsp_lines").setup()
	    end
	})

	-- Indent markers
	use "lukas-reineke/indent-blankline.nvim"

	-- Smooth Scrolling
	use 'karb94/neoscroll.nvim'

	-- Path Manipulation
        use 'nvim-lua/plenary.nvim'
	use 'yegappan/mru'

	use 'alexghergh/nvim-tmux-navigation'

	-- Colour Scheme
	use({
                "catppuccin/nvim",
		as = "catppuccin"
	})

	-- Colour code highlighting 
	use{
	    'norcalli/nvim-colorizer.lua',
	    config = function()
		require('colorizer').setup()
	    end
	}

end)
