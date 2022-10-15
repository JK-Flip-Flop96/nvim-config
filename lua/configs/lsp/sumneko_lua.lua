-- sumneko_lua configuration
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local navic = require("nvim-navic")

require('lspconfig').sumneko_lua.setup{
    capabilities = capabilities,
    settings = {
		Lua = {
	    	-- Ensure that the LSP server recognises the 'vim' global 
	    	-- and Packer's 'use' function
	    	diagnostics = {
				globals = { 'vim', 'use' }
			},
		}
    },
    on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
    end,
}
