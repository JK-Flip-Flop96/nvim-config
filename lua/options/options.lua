-- Settings
local set = vim.opt

--Terminal Colours
set.termguicolors = true

-- STYLE

-- Window Title
set.titlestring = "NeoVim"
set.title = true

-- Command Line
set.cmdheight = 0
set.showmode = false

-- Status Line
set.laststatus = 3

-- Sign Column
set.signcolumn = "yes" -- Prevents bouncing when the signcolumn is enabled/disabled

-- EDITOR

-- Line Numbers
set.number = true
set.relativenumber = true

-- Tab Width
set.tabstop = 4
set.shiftwidth = 4
set.showtabline = 1

-- Indent to the next tabstop automatically
set.smarttab = true

-- Keep extra line on screen when scrolling to provide context
set.scrolloff = 5 -- Vertical
set.sidescrolloff = 5 -- Horizontal

-- SEARCH FUNCTIONS

-- Search Highlighting
set.hlsearch = true

-- Incremental Search
set.incsearch = true

-- Case Insensitivity
set.ignorecase = true

-- Smart Case Sensitivity
set.smartcase = true
