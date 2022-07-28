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
    hl = { fg = "#a6adc8", bg = "#313244", bold = false },
}

-- Basic Ruler
local Ruler = {
    provider = " Ln %l/%L Cl %c %P ",
    hl = { fg ="#a6adc8", bg = "#313244"}
}

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

local Diagnostics = {
    consdition = conditions.has_diagnostics,

    static = {
	error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
	warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
	info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
	hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },

    init = function (self)
    	self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    	self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    	self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    	self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
	provider = " ",
	hl = { bg = "#45475a" },
    },
    {
	provider = function (self)
	    return self.errors > 0 and (self.error_icon .. self.errors .. " ")
	end,
	hl = { fg = "#f38ba8", bg = "#45475a" },
    },
    {
	provider = function (self)
	    return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
	end,
	hl = { fg = "#f9e2af", bg = "#45475a" },
    },
    {
	provider = function (self)
	    return self.info > 0 and (self.info_icon .. self.info .. " ")
	end,
	hl = { fg = "#89b4fa", bg = "#45475a" },
    },
    {
	provider = function (self)
	    return self.hints > 0 and (self.hint_icon .. self.hints)
	end,
	hl = { fg = "#94e2d5", bg = "#45475a" },
    },
    {
	provider = " ",
	hl = { bg = "#45475a" },
    },
}

-- Build out the status line
local statusline = {
    ViMode, WorkDir, Diagnostics, { provider = "%=" }, Ruler
}

require'heirline'.setup(statusline)
