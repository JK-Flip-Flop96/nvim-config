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

-- Get Alpha's Dashboard theme
local dashboard = require("alpha.themes.dashboard")

-- Remove the tildas after the buffer
vim.opt.fillchars:append { eob = " " }

vim.cmd [[ au User AlphaReady if winnr('$') == 1 | set laststatus=1 ]]

local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local nvim_web_devicons = {
    enabled = true,
    highlight = true,
}

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
    local file_button_el = dashboard.button(sc, ico_txt .. short_fn, ":set laststatus=3 | :e " .. fn .. " <CR>")
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

        local file_button_el = file_button(fn, shortcut, short_fn)
        tbl[i] = file_button_el
    end
    return {
        type = "group",
        val = tbl,
        opts = {},
    }
end

-- Set the Ascii Art used in the Header
dashboard.section.header.val = {
    [[__/\\\\\_____/\\\___________________________________________________________________________        ]],
    [[ _\/\\\\\\___\/\\\___________________________________________________________________________       ]],
    [[  _\/\\\/\\\__\/\\\_________________________________________________/\\\______________________      ]],
    [[   _\/\\\//\\\_\/\\\______/\\\\\\\\_______/\\\\\______/\\\____/\\\__\///______/\\\\\__/\\\\\___     ]],
    [[    _\/\\\\//\\\\/\\\____/\\\/////\\\____/\\\///\\\___\//\\\__/\\\____/\\\___/\\\///\\\\\///\\\_    ]],
    [[     _\/\\\_\//\\\/\\\___/\\\\\\\\\\\____/\\\__\//\\\___\//\\\/\\\____\/\\\__\/\\\_\//\\\__\/\\\_   ]],
    [[      _\/\\\__\//\\\\\\__\//\\///////____\//\\\__/\\\_____\//\\\\\_____\/\\\__\/\\\__\/\\\__\/\\\_  ]],
    [[       _\/\\\___\//\\\\\___\//\\\\\\\\\\___\///\\\\\/_______\//\\\______\/\\\__\/\\\__\/\\\__\/\\\_ ]],
    [[        _\///_____\/////_____\//////////______\/////__________\///_______\///___\///___\///___\///__]],
}
dashboard.section.header.opts.hl = "Function"

local section_mru = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Recent Files",
            opts = {
                hl = "SpecialComment",
                shrink_margin = false,
                position = "center",
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return { mru(0, cdir) }
            end,
            opts = { shrink_margin = false },
        },
    }
}

-- Denfine the Buttons in the "quick actions" section
local buttons = {
    type = "group",
    val = {
        { type = "text", val = "Quick Actions", opts = { hl = "SpecialComment", position = "center"}},
        { type = "padding", val = 1 },
        dashboard.button("n", "  New File",       ":set laststatus=3 | :ene <BAR> startinsert <CR>"),
	{ type = "padding", val = 1 },
        dashboard.button("v", "  Neovim Settings ",      ":set laststatus=3 | e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("u", "  Update Nvim Plugins",   ":PackerUpdate <CR>"),
	dashboard.button("m", "  Mason Installer", ":Mason <CR>"),
	{ type = "padding", val = 1 },
        dashboard.button("q", "  Quit Neovim",           ":qa<CR>"),
    },
    position = "center"
}

-- Define the Footer
dashboard.section.footer.val = {
    "Config by Stuart Miller 2022",
}

-- Define the order and position of elements on the screen
dashboard.config.layout = {
    { type = "padding", val = 5 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    section_mru,
    { type = "padding", val = 2 },
    buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
}

alpha.setup(dashboard.opts)
