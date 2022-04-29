-- KEYMAP

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving between splits with Ctrl + [HJKL]/Ctrl + [Arrow Keys]
keymap("n", "<A-h>", "<C-w>h", {})
keymap("n", "<A-Left>", "<C-w>h", {})

keymap("n", "<A-j>", "<C-w>j", {})
keymap("n", "<A-Up>", "<C-w>j", {})

keymap("n", "<A-k>", "<C-w>k", {})
keymap("n", "<A-Down>", "<C-w>k", {})

keymap("n", "<A-l>", "<C-w>l", {})
keymap("n", "<A-Right>", "<C-w>l", {})

-- Resizing splits with Alt + [HJKL]/Alt + [Arrow Keys]
keymap ("n", "<C-h>", ":vertical resize -5<cr>", {})
keymap ("n", "<C-Left>", ":vertical resize -5<cr>", {})

keymap ("n", "<C-j>", ":resize +5<cr>", {})
keymap ("n", "<C-Up>", ":resize +5<cr>", {})

keymap ("n", "<C-k>", ":resize -5<cr>", {})
keymap ("n", "<C-Down>", ":resize -5<cr>", {})

keymap ("n", "<C-l>", ":vertical resize +5<cr>", {})
keymap ("n", "<C-Right>", ":vertical resize +5<cr>", {})


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