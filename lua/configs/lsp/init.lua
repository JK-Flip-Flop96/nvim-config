-- LSP SETTINGS

-- LSP servers
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local navic = require("nvim-navic")

-- clangd
require('lspconfig').clangd.setup{
    capabilities = capabilities
}

-- csharp_ls (C#) 
require('lspconfig').csharp_ls.setup{
    capabilities = capabilities
}

-- gopls
require('lspconfig').gopls.setup{
    capabilities = capabilities
}

-- hls
require('lspconfig').hls.setup{
    capabilities = capabilities
}

-- julials
require('lspconfig').julials.setup{
    capabilities = capabilities
}

-- pyright
require("lspconfig").pyright.setup{
    capabilities = capabilities
}

-- rust analyzer
require('lspconfig').rust_analyzer.setup{
    capabilities = capabilities
}

-- sumneko lua 
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

-- taplo
require('lspconfig').taplo.setup{
    capabilities = capabilities
}

-- yamlls 
require('lspconfig').yamlls.setup{
    capabilities = capabilities
}
