-- Custom Configuration for Heirline

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

    provider = function(self)
	return " %2("..self.mode_names[self.mode].." %)"
    end,

    hl = function(self)
	-- Get the first chatacter of the mode
	local mode = self.mode:sub(1, 1)

	-- Get the pair of colours from the table
	local m_colors = self.mode_colors[mode]

	-- Return the highlight
	return {bg = m_colors[1], fg = m_colors[2], }
    end,

    update = "ModeChanged"
}

-- Get the cwd and add it to the statusline. 
local WorkDir = {
    provider = function()
	local icon = (vim.fn.haslocaldir(0) == 1 and " l" or " g") .. " " .. " "
	local cwd = vim.fn.getcwd(0)
	cwd = vim.fn.fnamemodify(cwd, ":~")
	if not conditions.width_percent_below(#cwd, 0.25) then
	    cwd = vim.fn.pathshorten(cwd)
	end
	local trail = cwd:sub(-1) == '/' and ' ' or "/ "
	return icon .. cwd .. trail
    end,
    hl = { fg = "#f9e2af", bg = "#313244", bold = false },
}

-- Basic Ruler
local Ruler = {
    provider = " Ln %l/%L Cl %c %P ",
    hl = { fg ="#a6adc8", bg = "#313244"}
}

-- Build out the status line
local statusline = {
    ViMode, WorkDir, { provider = "%=" }, Ruler
}

require'heirline'.setup(statusline)
