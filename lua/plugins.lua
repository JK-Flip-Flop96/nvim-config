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

	-- Startup performance enhancement
	use "lewis6991/impatient.nvim"

	-- Completions
	use "neovim/nvim-lspconfig" -- LSP configs for Nvim
	use "williamboman/nvim-lsp-installer" -- Installer for LSPs
	
	-- Completion Sources
	use "hrsh7th/cmp-buffer" -- Completions for words in the buffer
	use "hrsh7th/cmp-path" -- Completions for filesystem paths
	use "hrsh7th/cmp-cmdline" -- Completions for vim's command line
	use "octaltree/cmp-look" -- Look-based work lookupp
	use "hrsh7th/nvim-cmp" -- Completions plugin

	-- LuaSnip
	use "L3MON4D3/LuaSnip" -- Snippets
	use "saadparwaiz1/cmp_luasnip" -- Cmp/LuaSnip Compatability

	-- Indent markers
	use "lukas-reineke/indent-blankline.nvim"
	
	-- Smooth Scrolling
	use 'karb94/neoscroll.nvim'

        use 'nvim-lua/plenary.nvim'

	use 'yegappan/mru'

	use 'alexghergh/nvim-tmux-navigation'

	use({
                "catppuccin/nvim",
		as = "catppuccin"
	})

	use{
	    'norcalli/nvim-colorizer.lua',
	    config = function()
		require('colorizer').setup()
	    end
	}

end)
