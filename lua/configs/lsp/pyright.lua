-- pyright configuration
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local navic = require("nvim-navic")

require("lspconfig").pyright.setup{
    capabilities = capabilities,
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
	end,
}
