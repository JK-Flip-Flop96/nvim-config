-- Custom Configuration for Heirline

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
	    t = "T",
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

-- Build out the status line
local statusline = {
    ViMode,    
}

require'heirline'.setup(statusline)
