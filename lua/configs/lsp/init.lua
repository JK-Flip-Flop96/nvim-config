-- LSP SETTINGS

-- Call into the dedicated files for other servers
require 'configs.lsp.sumneko_lua'
require 'configs.lsp.pyright'
require 'configs.lsp.null-ls'

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



-- rust analyzer
require('lspconfig').rust_analyzer.setup{
    capabilities = capabilities
}

-- taplo
require('lspconfig').taplo.setup{
    capabilities = capabilities
}

-- yamlls 
require('lspconfig').yamlls.setup{
    capabilities = capabilities
}
