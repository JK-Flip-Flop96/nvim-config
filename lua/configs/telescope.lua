local telelscope_status, telescope = pcall(require, "telescope")
if not telelscope_status then
  return
end

local builtin = require("telescope.builtin")
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

telescope.setup({
	defaults = {
		borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
	}
})
