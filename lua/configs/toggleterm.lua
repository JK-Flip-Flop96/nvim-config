-- Load Toggleterm
local toggleterm_status, toggleterm = pcall(require, "toggleterm")
if not toggleterm_status then
	return
end

-- Setup Toggleterm
toggleterm.setup()

-- Terminals -- 
-- 
local Terminal = require("toggleterm.terminal").Terminal

-- Lazygit Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- Functions --

-- Function to toggle lazygit
function Lazygit_Toggle()
	lazygit:toggle()
end

-- Keybinds --

vim.api.nvim_set_keymap("n", "<leader>tg", ":lua Lazygit_Toggle()<CR>", { noremap = true, silent = true })
