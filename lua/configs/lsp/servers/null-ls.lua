local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
	},
})
