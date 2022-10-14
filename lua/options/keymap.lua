-- KEYMAP

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Resizing splits with Alt + [HJKL]/Alt + [Arrow Keys]
keymap ("n", "<A-h>", ":vertical resize -5<cr>", {})
keymap ("n", "<A-Left>", ":vertical resize -5<cr>", {})

keymap ("n", "<A-j>", ":resize +5<cr>", {})
keymap ("n", "<A-Up>", ":resize +5<cr>", {})

keymap ("n", "<A-k>", ":resize -5<cr>", {})
keymap ("n", "<A-Down>", ":resize -5<cr>", {})

keymap ("n", "<A-l>", ":vertical resize +5<cr>", {})
keymap ("n", "<A-Right>", ":vertical resize +5<cr>", {})

keymap ("n", "<F1>", ":Telescope help_tags<cr>", {})

keymap ("n", "<Leader>tg", ":2TermExec cmd=lazygit direction=float<cr>", {})

-- Tmux Navigation Compatibility
vim.cmd([[
nnoremap <silent> <C-h> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>
nnoremap <silent> <C-j> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<CR>
nnoremap <silent> <C-k> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<CR>
nnoremap <silent> <C-l> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<CR>
nnoremap <silent> <C-\> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<CR>
nnoremap <silent> <C-Space> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<CR>
]])
