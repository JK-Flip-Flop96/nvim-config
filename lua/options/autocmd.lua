-- ## AUTOCMDS ## --

-- CursorLine -- 

-- Show/hide cursorline based on which window is active
vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, -- activate cursorline upon entering a window
	{ pattern = "*", command = "setlocal cursorline", group = "CursorLine" }
)
vim.api.nvim_create_autocmd({"WinLeave"}, -- deactivate cursorline upon leaving a window
	{ pattern = "*", command = "setlocal nocursorline", group = "CursorLine" }
)
