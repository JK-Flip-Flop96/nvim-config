vim.api.nvim_create_augroup("CursorLine", { clear = true })

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"},
	{ pattern = "*", command = "setlocal cursorline", group = "CursorLine" }
)

vim.api.nvim_create_autocmd({"WinLeave"},
	{ pattern = "*", command = "setlocal nocursorline", group = "CursorLine" }
)
