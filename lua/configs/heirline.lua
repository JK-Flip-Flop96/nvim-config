-- Custom Configuration for Heirline

-- ## STATUS LINE COMPONENTS ## ==

-- Load Heirline's utilities
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- Mode Indicator - Modified from the Heirline Cookbook
local ViMode = {
    init = function(self)
	self.mode = vim.fn.mode(1)

	if not self.once then
	    vim.api.nvim_create_autocmd("ModeChanged", {command = 'redrawstatus'})
	end
    end,

    -- Define the text used in each mode
    static = {
	mode_names = {
	    n = "NORMAL",
	    no = "NORMAL [?]",
	    nov = "NORMAL [?]",
	    noV = "NORMAL [?]",
	    ["no\22"] = "NORMAL [?]",
	    niI = "NORMAL [i]",
	    niR = "NORMAL [r]",
	    niV = "NORMAL [v]",
	    nt = "NORMAL [t]",
	    v = "VISUAL",
	    vs = "VISUAL [s]",
	    V = "VISUAL_",
	    Vs = "VISUAL [s]",
	    ["\22"] = "^VISUAL",
	    ["\22s"] = "^VISUAL",
	    s = "SELECT",
	    S = "SELECT_",
	    ["\19"] = "^SELECT",
	    i = "INSERT",
	    ic = "INSERT [c]",
	    ix = "INSERT [x]",
	    R = "REPLACE",
	    Rc = "REPLACE [c]",
	    Rx = "REPLACE [x]",
	    Rv = "REPLACE [v]",
	    Rvc = "REPLACE [v]",
	    Rvx = "REPLACE [v]",
	    c = "COMMAND",
	    cv = "EX",
	    r = "...",
	    rm = "M",
	    ["r?"] = "?",
	    ["!"] = "!",
	    t = "TERMINAL",
	},
	-- Define the color used in each mode
	mode_colors = {
	    n = {"#89b4fe", "#1e1e2e"},
	    i = {"#a6e3a1", "#1e1e2e"},
	    v = {"#94e2d5", "#1e1e2e"},
	    V = {"#94e2d5", "#1e1e2e"},
	    ["\22"] = {"#94e2d5", "#1e1e2e"},
	    c = {"#fab387", "#1e1e2e"},
	    s = {"#cba6f7", "#1e1e2e"},
	    S = {"#cba6f7", "#1e1e2e"},
	    ["\19"] = {"#cba6f7", "#1e1e2e"},
	    R = {"#fab387", "#1e1e2e"},
	    r = {"#fab387", "#1e1e2e"},
	    ["!"] = {"#f38ba8", "#1e1e2e"},
	    t = {"#f38ba8", "#1e1e2e"},
	}
    },

    -- Define the layout of the indicator
    provider = function(self)
	return " %2("..self.mode_names[self.mode].." %)"
    end,

    -- Define the colours of the indicator
    hl = function(self)
	-- Get the first chatacter of the mode
	local mode = self.mode:sub(1, 1)

	-- Get the pair of colours from the table
	local m_colors = self.mode_colors[mode]

	-- Return the highlight
	return {bg = m_colors[1], fg = m_colors[2], }
    end,

    -- Update when the vim mode changes
    update = "ModeChanged"
}

-- Get the cwd and add it to the statusline. 
local WorkDir = {
    provider = function()
	-- Prepend a 'g' for a global working directory or an 'l' for a local working directory
	local icon = (vim.fn.haslocaldir(0) == 1 and " l" or " g") .. " " .. " "

	-- Get the current working directory
	local cwd = vim.fn.getcwd(0)

	-- Shorten the cwd relative to the home dir if appropriate
	cwd = vim.fn.fnamemodify(cwd, ":~")

	-- Shorten the cwd if it's too long
	if not conditions.width_percent_below(#cwd, 0.25) then
	    cwd = vim.fn.pathshorten(cwd)
	end

	-- Add a trailing space and a slash if there isn't one
	local trail = cwd:sub(-1) == '/' and ' ' or "/ "

	-- Concatonate the icon and cwd
	return icon .. cwd .. trail
    end,

    -- Set the colour
    hl = { fg = "#a6adc8", bg = "#313244", bold = false },
}

-- Basic Ruler
local Ruler = {
    provider = " Ln %l/%L Cl %c %P ",
    hl = { fg ="#a6adc8", bg = "#313244"}
}

-- Diagnostics signs 
local Diagnostics = {
    -- Only display this component if diagnostics are available for the current buffer
    consdition = conditions.has_diagnostics,

    -- Get the icons for the diagnostics
    static = {
	error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
	warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
	info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
	hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },

    -- Get the counts for each type of diagnostic message
    init = function (self)
    	self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    	self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    	self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    	self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	self.total = self.errors + self.warnings + self.hints + self.info
    end,

    -- Update when the diagnostics change or when entering a new buffer
    update = { "DiagnosticChanged", "BufEnter" },

    -- Define the text to display
    {
	-- Leading space
	provider = function (self)
	    return self.total > 0 and " "
	end,
	hl = { bg = "#45475a" },
    },
    {
	-- Errors
	provider = function (self)
	    return self.errors > 0 and (self.error_icon .. self.errors .. " ")
	end,
	hl = { fg = "#f38ba8", bg = "#45475a" },
    },
    {
	-- Warnings
	provider = function (self)
	    return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
	end,
	hl = { fg = "#f9e2af", bg = "#45475a" },
    },
    {
	-- Info
	provider = function (self)
	    return self.info > 0 and (self.info_icon .. self.info .. " ")
	end,
	hl = { fg = "#89b4fa", bg = "#45475a" },
    },
    {
	-- Hints
	provider = function (self)
	    return self.hints > 0 and (self.hint_icon .. self.hints)
	end,
	hl = { fg = "#94e2d5", bg = "#45475a" },
    },
    {
	-- Trailing space
	provider = function (self)
	    return self.total > 0 and " "
	end,
	hl = { bg = "#45475a" },
    },
}

-- File Type/Info 

local FileIcon = {
    init = function(self)
	local filename = self.filename
	local extension = vim.fn.fnamemodify(filename, ":e")

	self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
	return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
	return { fg = self.icon_color }
    end
}

-- Build out the status line
local statusline = {
    ViMode, WorkDir, Diagnostics, { provider = "%=" }, Ruler
}

-- ## WINBAR ## --

local Navic = {
    condition = require("nvim-navic").is_available,
    static = {
	type_hl = {
	    File = "Directory",
	    Module = "Include",
	    Namespace = "TSNamespace",
	    Package = "Include",
	    Class = "Struct",
	    Method = "Method",
	    Property = "TSProperty",
	    Field = "TSField",
	    Constructor = "TSConstructor",
	    Enum = "TSField",
	    Interface = "Type",
	    Function = "Function",
	    Variable = "TSVariable",
	    Constant = "Constant",
	    String = "String",
	    Number = "Number",
	    Boolean = "Boolean",
	    Array = "TSField",
	    Key = "TSKeyword",
	    Null = "Comment",
	    EnumMember = "TSField",
	    Struct = "Struct",
	    Event = "Keyword",
	    Operator = "Operator",
	    TypeParameter = "Type",
	},
    },
    init = function(self)
	local data = require("nvim-navic").get_data() or {}
	local children = {}

	for i, d in ipairs(data) do
	    local child = {
		{
		    provider = d.icon,
		    hl = self.type_hl[d.type],
		},
		{
		    provider = d.name,
		},
	    }

	    if #data > 1 and i < #data then
		table.insert(child, {
		    provider = " > ",
		    hl = { fg = "#a6adc8" },
		})
	    end

	    table.insert(children, child)

	end

	self[1] = self:new(children, 1)
    end,
    hl = { fg = "#a6adc8" },
}


-- Build out the winbar
local winbar = { Navic }

-- ## TABLINE ## --

-- Get the number of the buffer
local TablineBufnr = {
    provider = function(self)
	return tostring(self.bufnr) .. ": "
    end,
    hl = { fg = "#a6adc8" },
}

-- Get the file's name 
local TablineFileName = {
    provider = function(self)
	local filename = self.filename
	filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
	return filename
    end,
    -- Bold the text if the buffer is visible 
    hl = function (self)
	return { bold = self.is_active or self.is_visible }
    end,
}

-- Add additional icons to the block based on the file's flags
local TablineFileFlags = {
    {
	provider = function(self)
	    if vim.bo[self.bufnr].modified then
		return " "
	    end
	end,
	hl = { fg = "#a6e3a1" }
    },
    {
	provider = function(self)
	    if not vim.bo[self.bufnr].modifiable or vim.bo[self.bufnr].readonly then
		return " "
	    end
	end,
	hl = { fg = "#fab387" },
    },
}

-- Construct the final file name block
local TablineFileNameBlock = {
    -- Get the file's name on initialisation
    init = function(self)
	self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
	if self.is_active then
	    return "TabLineSel"
	else
	    return "TabLine"
	end
    end,
    on_click = {
	callback = function(_, minwid, _, button)
	    if (button == "m") then
		vim.api.nvim_buf_delete(minwid, { force = false })
	    else
		vim.api.nvim_win_set_buf(0, minwid)
	    end
	end,
	minwid = function(self)
	    return self.bufnr
	end,
	name = "heirline_tabline_buffer_callback"
    },
    TablineBufnr,
    FileIcon,
    TablineFileName,
    TablineFileFlags,
}

-- Add a close button to the buffer block
local TablineCloseButton = {
    condition = function (self)
        return not vim.bo[self.bufnr].modified
    end,
    { provider = " " },
    {
	provider = "",
	on_click = {
	    callback = function(_, minwid)
		vim.api.nvim_buf_delete(minwid, { force = false })
	    end,

	    minwid = function(self)
		return self.bufnr
	    end,
	    name = "heirline_tabline_close_buffer_callback",
	},
    },
    hl = function(self)
	if self.is_active then
	    return "TabLineSel"
	else
	    return "TabLine"
	end
    end,
}

local TablineBufferBlockLeft = {
    provider = "▎",
    hl = function(self)
	if self.is_active then
	    return { bg = utils.get_highlight("TablineSel").bg, fg = utils.get_highlight("TablineFill").bg }
	else
	    return { bg = utils.get_highlight("Tabline").bg, fg = utils.get_highlight("TablineFill").bg }
	end
    end,
}

local TablineBufferBlockRight = {
    provider = "▊",
    hl = function(self)
	if self.is_active then
	    return { bg = utils.get_highlight("TablineFill").bg, fg = utils.get_highlight("TablineSel").bg }
	else
	    return { bg = utils.get_highlight("TablineFill").bg, fg = utils.get_highlight("Tabline").bg }
	end
    end,
}

-- Construct the final buffer block
local TablineBufferBlock = { TablineBufferBlockLeft, TablineFileNameBlock, TablineCloseButton, TablineBufferBlockRight }

-- Construct the bufferline using the elements defined above
local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    -- Define the icons used for left/right truncation
    { provicer = "", hl = { fg = "#a6adc8" }},
    { provicer = "", hl = { fg = "#a6adc8" }}
)

local TabPage = {
    provider = function(self)
	return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
    end,
    hl = function(self)
	if not self.is_active then
	    return "TabLine"
	else
	    return "TabLineSel"
	end
    end,
}

local TabPageClose = {
    provider = "%999X  %X",
    hl = "TabLine",
}

local TabPages = {
    condition = function()
	return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" }, -- Make this component right justified
    utils.make_tablist(TabPage),
    TabPageClose,
}

-- Build out the tabline
local tabline = { BufferLine, TabPages }

-- Set the statusline
require'heirline'.setup(statusline, winbar, tabline)
