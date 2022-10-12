local neoscroll_status, neoscroll = pcall(require, 'neoscroll')

if not neoscroll_status then
	return
end

neoscroll.setup({
	respect_scrolloff = true,
})

local keymap = {}

-- Define a custom keymap for scrolling
keymap['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '125'}}
keymap['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '125'}}
keymap['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '225'}}
keymap['<PageUp>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '225'}}
keymap['<C-f>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '225'}}
keymap['<PageDown>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '225'}}
keymap['<C-y>'] = {'scroll', {'-0.10', 'true', '50'}}
keymap['<C-e>'] = {'scroll', {'0.10', 'true', '50'}}
keymap['zt'] = {'zt', {'125'}}
keymap['zz'] = {'zz', {'125'}}
keymap['zb'] = {'zb', {'125'}}

require('neoscroll.config').set_mappings(keymap)
