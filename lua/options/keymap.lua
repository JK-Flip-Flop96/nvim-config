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

-- Tmux Navigation Compatibility
vim.cmd([[
nnoremap <silent> <C-h> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>
nnoremap <silent> <C-j> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<CR>
nnoremap <silent> <C-k> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<CR>
nnoremap <silent> <C-l> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<CR>
nnoremap <silent> <C-\> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<CR>
nnoremap <silent> <C-Space> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<CR>
]])		
