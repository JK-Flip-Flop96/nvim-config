-- Load and Ready Alpha.nvim
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

-- Load and Ready Plenary
local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
    return
end

-- Remove the tildas after the buffer
vim.opt.fillchars:append { eob = " " }

vim.cmd [[ au User AlphaReady if winnr('$') == 1 | set laststatus=1 ]]
vim.cmd [[ autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]]


local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local nvim_web_devicons = {
    enabled = true,
    highlight = true,
}

local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 60,
		align_shortcut = "right",
		hl_shortcut = "AlphaShortcut",
	}

	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

-- Get the file extension for a given file
local function get_extension(fn)
    local match = fn:match("^.+(%..+)$")
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

-- Get the icon nwd for a given file name
local function icon(fn)
    local nwd = require("nvim-web-devicons")
    local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, { default = true })
end

-- Generate a button for a given file
local function file_button(fn, sc, short_fn)
    short_fn = short_fn or fn
    local ico_txt
    local fb_hl = {}

    if nvim_web_devicons.enabled then
        local ico, hl = icon(fn)
        local hl_option_type = type(nvim_web_devicons.highlight)
        if hl_option_type == "boolean" then
            if hl and nvim_web_devicons.highlight then
                table.insert(fb_hl, { hl, 0, 3 })
            end
        end
        if hl_option_type == "string" then
            table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
        end
        ico_txt = ico .. "  "
    else
        ico_txt = ""
    end
    local file_button_el = button(sc, ico_txt .. short_fn, ":set laststatus=3 | :e " .. fn .. " <CR>")
    local fn_start = short_fn:match(".*[/\\]")
    if fn_start ~= nil then
        table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
end

-- Remove gitcommit message buffers from the MRU list
local default_mru_ignore = { "gitcommit" }

local mru_opts = {
    ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
    end,
}

--- @param start number
--- @param cwd string optional
--- @param items_number number optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
    opts = opts or mru_opts
    items_number = if_nil(items_number, 10)

    local oldfiles = {}
    for _, v in pairs(vim.v.oldfiles) do
        if #oldfiles == items_number then
            break
        end
        local cwd_cond
        if not cwd then
            cwd_cond = true
        else
            cwd_cond = vim.startswith(v, cwd)
        end
        local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
        if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
        end
    end
    local target_width = 35

    local tbl = {}
    for i, fn in ipairs(oldfiles) do
        local short_fn
        if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
        else
            short_fn = vim.fn.fnamemodify(fn, ":~")
        end

        if(#short_fn > target_width) then
          short_fn = plenary_path.new(short_fn):shorten(1, {-2, -1})
          if(#short_fn > target_width) then
            short_fn = plenary_path.new(short_fn):shorten(1, {-1})
          end
        end

		local shortcut = tostring(i+start-1)

		--HACK to change 10 to 0
		if shortcut == "10" then
			shortcut = "0"
		end

        local file_button_el = file_button(fn, shortcut, short_fn)
        tbl[i] = file_button_el
    end
    return {
        type = "group",
        val = tbl,
        opts = {},
    }
end

local header_text = {
	[[████████████████████████████████████]],
	[[██░░░████░░█░░████░░█░░█░░░████░░░██]],
	[[██░░░░███░░█░░████░░█░░█░░░░██░░░░██]],
	[[██░░█░░██░░█░░████░░█░░█░░█░░░░█░░██]],
	[[██░░██░░█░░██░░██░░██░░█░░██░░██░░██]],
	[[██░░███░░░░███░░░░███░░█░░██████░░██]],
	[[████████████████████████████████████]],
}

local function build_header()
	local lines = {}
	for _, line_chars in pairs(header_text) do
		local line = {
			type = "text",
			val = line_chars,
			opts = {
				hl = "AlphaHeader",
				shrink_margin = true,
				position = "center",
			},
		}
		table.insert(lines, line)
	end

	-- Set the Ascii Art used in the Header
	local header = {
		type = "group",
		val = lines,
		opts = {
			position = "center",
		}
	}

	return header
end

local section_mru = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Recent Files",
            opts = {
                hl = "AlphaSectionHeader",
                shrink_margin = false,
                position = "center",
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return { mru(1, cdir, 10) }
            end,
            opts = { shrink_margin = false },
        },
    }
}

-- Denfine the Buttons in the "quick actions" section
local buttons = {
    type = "group",
    val = {
        { type = "text", val = "Quick Actions", opts = { hl = "AlphaSectionHeader", position = "center"}},
        { type = "padding", val = 1 },
        button("n", "  New File",       ":set laststatus=3 | :ene <BAR> startinsert <CR>"),
		button("t", "פּ  Open File Tree", ":set laststatus=3 | :NvimTreeOpen <CR>"),
		{ type = "padding", val = 1 },
		button("ff", "  Find File",     ":set laststatus=3 | :Telescope find_files <CR>"),
		button("fg", "  Find Text",     ":set laststatus=3 | :Telescope live_grep <CR>"),
		{ type = "padding", val = 1 },
        button("v", "  Neovim Configuration ",      ":set laststatus=3 | :cd ~/.config/nvim | :e init.lua | :NvimTreeOpen <CR>"),
		{ type = "padding", val = 1 },
        button("u", "  Update Nvim Plugins",   ":PackerUpdate <CR>"),
		button("m", "  Mason Installer", ":Mason <CR>"),
		{ type = "padding", val = 1 },
        button("q", "  Quit Neovim",           ":qa<CR>"),
    },
    position = "center",
	hl_shortcut = "AlphaShortcut",
}

local footer = {
	type = "text",
	val = function()
		local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start/", "*", 0, 1))
		local lazy_plugin_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/opt/", "*", 0, 1))
		local nvim_version = vim.version()
		local nvim_version_string = string.format("%s.%s.%s", nvim_version.major, nvim_version.minor, nvim_version.patch)

		return " " .. plugins_count .. "/" .. plugins_count + lazy_plugin_count .. "   " .. nvim_version_string
	end,
	opts = {
		position = "center",
		hl = "AlphaFooter",
	}
}

-- Define the order and position of elements on the screen
local layout = {
    { type = "padding", val = 5 },
    build_header(),
    { type = "padding", val = 2 },
    section_mru,
    { type = "padding", val = 2 },
    buttons,
    { type = "padding", val = 1 },
    footer,
}

alpha.setup({ layout = layout })
