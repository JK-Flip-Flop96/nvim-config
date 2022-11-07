-- sumneko_lua configuration
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local navic = require("nvim-navic")

require('lspconfig').sumneko_lua.setup{
    capabilities = capabilities,
    settings = {
		Lua = {
			-- LuaJIT in the case of Neovim
			runtime = {
				version = 'LuaJIT',
			},
	    	-- Ensure that the LSP server recognises the 'vim' global 
	    	-- and Packer's 'use' function
	    	diagnostics = {
				globals = { 'vim', 'use' }
			},
			workspace = {
				-- Get the language server to recognise Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				-- Disable telemetry
				enable = false,
			},
		},
    },
    on_attach = function(client, bufnr)
		-- Attach Navic
		navic.attach(client, bufnr)
    end,
}
