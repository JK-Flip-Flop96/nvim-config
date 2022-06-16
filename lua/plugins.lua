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

        -- File Manager
	use(
	    {
		"lmburns/lf.nvim",
		config = function()
		    vim.g.lg_netrw = 1

		    require("lf").setup(
			{
			    escape_quit = false,
			    border = "rounded",
			    highlights = {FloatBorder = {guifg = require("kimbox.palette").colors.magenta}}
			}
		    )

		    vim.keymap.set("n", "<C-o>", ":Lf<CR>")
		end,
		requires = {
		    "plenary.nvim",
		    "toggleterm.nvim"
		}
	    }
	)

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
	use "hrsh7th/nvim-cmp" -- Base plugin
  	use "L3MON4D3/LuaSnip" -- Snippets

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
