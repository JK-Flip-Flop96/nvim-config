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

	-- File Tree
	use {
		'kyazdani42/nvim-tree.lua',
		cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
		config = function()
		  	require('nvim-tree').setup {
				update_focused_file = {enable = true, update_cwd = true}
		  	}
		end
	}
	  

	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}

	-- Tree Sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use 'goolord/alpha-nvim'

	use {
		'RRethy/nvim-base16',
		config = function()
			vim.cmd('colorscheme base16-tomorrow-night')
		end
	}

	use "nvim-lualine/lualine.nvim"

	use {
		'lewis6991/gitsigns.nvim',
		config = function()
		  	require('gitsigns').setup()
		end
	}

	use "lewis6991/impatient.nvim"
	use "hrsh7th/nvim-cmp"
  	use "L3MON4D3/LuaSnip"

end)
