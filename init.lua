-- Plugin Management
require "plugins"

-- Plugin Config Files
require "configs/alpha-nvim"
require "configs/nvim-tree"
require "configs/treesitter"

-- Settings
local set = vim.opt

-- STYLE

-- Window Title
set.titlestring = "NeoVim"
set.title = true

-- Command Line
set.cmdheight = 1

-- EDITOR

-- Line Numbers
set.number = true
set.relativenumber = true

-- TabWidth
set.shiftwidth = 4
set.showtabline = 1

-- SEARCH FUNCTIONS

-- Search Highlighting
set.hlsearch = true

-- Incremental Search
set.incsearch = true

-- Case Insensitivity
set.ignorecase = true

-- Smart Case Sensitivity
set.smartcase = true

-- KEYMAP

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving between splits with Ctrl + [HJKL]
keymap("n", "<A-h>", "<C-w>h", {})
keymap("n", "<A-j>", "<C-w>j", {})
keymap("n", "<A-k>", "<C-w>k", {})
keymap("n", "<A-l>", "<C-w>l", {})

-- Resizing splits with Alt + [HJKL]
keymap ("n", "<C-h>", ":vertical resize -5<cr>", {})
keymap ("n", "<C-j>", ":resize +5<cr>", {})
keymap ("n", "<C-k>", ":resize -5<cr>", {})
keymap ("n", "<C-l>", ":vertical resize +5<cr>", {})


-- Auto Pairs
vim.cmd([[
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>0
inoremap {;<CR> {<CR>};<ESC>0
nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap " ""<left>
inoremap ' ''<left>
]])


  
