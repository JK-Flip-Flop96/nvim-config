-- Load and Ready Cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

-- Load and Ready LuaSnip
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

-- Configure LuaSnip's Loader
require("luasnip/loaders/from_vscode").lazy_load()

--
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- Configure icons for use by cmp
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- Cmp configuration
cmp.setup {
    snippet = {
	expand = function(args)
	    luasnip.lsp_expand(args.body)
	end,
    },
    --: Cmp Key Mapping
    mapping = cmp.mapping.preset.insert({
	["<C-k>"] = cmp.mapping.select_prev_item(),
	["<C-j"] = cmp.mapping.select_next_item(),
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c"}),
	["<C-y>"] = cmp.config.disable,
	["<C-e>"] = cmp.mapping {
	    i = cmp.mapping.abort(),
	    c = cmp.mapping.close(),
	},
	["<CR>"] = cmp.mapping.confirm { select = true },
    }),
    -- Cmp Formatting
    formatting = {
	fields = {"kind", "abbr", "menu"},
	format = function(entry, vim_item)
	    -- Set the icons defined above
	    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

	    vim_item.menu = ({
		nvim_lsp = "[LSP]",
		luasnip = "[Snippet]",
		copilot = "[Copilot]",
	    })[entry.source.name]
	    return vim_item
	end,
    },
    -- Cmp Sources
    sources = cmp.config.sources({
	{ name = "copilot" },
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "look" },
	{ name = "path" },
	{ name = "buffer" },
	{ name = "cmdline" },
    }),

    -- Cmp Experimental Features
    experimental = {
	ghost_text = true
    },
}

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
	{ name = 'cmp_git' },
    }, {
	{ name = 'buffer'},
    })
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
	{ name = 'path' }
    }, {
	{ name = 'cmdline' }
    })
})


-- LSP SETTINGS

-- Mason setup
require("mason").setup({
    ui = {
	icons = {
	    server_installed = "✓",
	    server_pending = "➜",
	    server_uninstalled = "✗"
	}
    }
})

-- LSP servers
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- clangd
require('lspconfig').clangd.setup{
    capabilities = capabilities
}

-- csharp_ls 
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
	    diagnostics = {
		globals = { 'vim' },
	    },
	}
    }
}

-- taplo
require('lspconfig').taplo.setup{
    capabilities = capabilities
}

-- yamlls 
require('lspconfig').yamlls.setup{
    capabilities = capabilities
}
