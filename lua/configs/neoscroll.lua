local neoscroll_status, neoscroll = pcall(require, 'neoscroll')

if not neoscroll_status then
	return
end

neoscroll.setup({
	respect_scrolloff = true,
})

local keymap = {}

-- Define a custom keymap for scrolling
keymap['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
keymap['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '250'}}
keymap['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
keymap['<C-f>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '450'}}
keymap['<C-y>'] = {'scroll', {'-0.10', 'true', '100'}}
keymap['<C-e>'] = {'scroll', {'0.10', 'true', '100'}}
keymap['zt'] = {'zt', {'250'}}
keymap['zz'] = {'zz', {'250'}}
keymap['zb'] = {'zb', {'250'}}

require('neoscroll.config').set_mappings(keymap)
