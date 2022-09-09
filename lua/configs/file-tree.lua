local nvim_tree = require("nvim-tree")

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
	unstaged = "",
        staged = "S",
        unmerged = "",
	renamed = "➜",
	deleted = "",
	untracked = "U",
	ignored = "◌",
    },
    folder = {
	default = "",
	open = "",
	empty = "",
	empty_open = "",
	symlink = "",
    },
}

nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
	"startify",
	"dashboard",
	"alpha",
    },
    auto_reload_on_write = true,
    hijack_unnamed_buffer_when_opening = false,
    hijack_directories = {
	enable = true,
	auto_open = true,
    },
    diagnostics = {
	enable = true,
	icons = {
	    hint = "",
	    info = "",
	    warning = "",
	    error = "",
	}
    },
    update_focused_file = {
	enable      = true,
	update_cwd  = true,
	ignore_list = {}
    },
    system_open = {
	cmd  = nil,
	args = {}
    },
    filters = {
	dotfiles = false,
	custom = {}
	},
    git = {
	enable = true,
	ignore = true,
	timeout = 500,
    },
    view = {
	width = 33,
	height = 30,
	hide_root_folder = false,
	side = "left",
	-- auto_resize = false,
	mappings = {
	    custom_only = false,
	    list = {
		{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
		{ key = "h", cb = tree_cb "close_node" },
		{ key = "v", cb = tree_cb "vsplit" },
		{ key = "H", cb = tree_cb "split" },
		{ key = "o", cb = tree_cb "vsplit" },
	    },
	},
	number = false,
	relativenumber = false,
    },
    trash = {
	cmd = "trash",
	require_confirm = true
    },
    actions = {
	change_dir = {
	    global = false,
	},
	open_file = {
	    quit_on_open = true,
	    window_picker = {
		enable = true,
		chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
		exclude = {
		    filetype = {
			"notify",
			"packer",
			"qf"
		    }
		}
	    }
	}
    }
})

local tree = {}

function tree.open()
    require'bufferline.state'.set_offset(0)
    require'nvim-tree'.find_file(true)
end

function tree.close()
    require'bufferline.state'.set_offset(0)
    require'nvim-tree'.close()
end

return tree
