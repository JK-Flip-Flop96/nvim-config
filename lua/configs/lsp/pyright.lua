-- pyright configuration
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local navic = require("nvim-navic")

require("lspconfig").pyright.setup{
    capabilities = capabilities,
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
	end,
}
