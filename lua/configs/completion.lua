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
    -- Cmp Key Mapping
    mapping = {
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
	["<CR>"] = cmp.mapping.confirm { select = false }, 
	["<Tab>"] = cmp.mapping.confirm(function(fallback)
	    if cmp.visible() then
		cmp.select_next_item()
	    elseif luasnip.expandable() then
		luasnip.expand()
	    elseif luasnup.expand_or_jumpable() then
		luasnip.expand_or_jump()
	    elseif check_backspace() then
		fallback()
	    else
		fallback()
	    end
	end, {
	    "i",
	    "s",
	}),
	["<S-Tab>"] = cmp.mapping(function(fallback)
	    if cmp.visible() then
		cmp.select_prev_item()
	    elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	    else
		fallback()
	    end
	end, {
	    "i",
	    "s", 
	}),
    },
    -- Cmp Formatting
    formatting = {
	fields = {"kind", "abbr", "menu"},
	format = function(entry, vim_item)
	    -- Set the icons defined above
	    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

	    vim_item.menu = ({
		nvim_lsp = "[LSP]",
		luasnip = "[Snippet]"
	    })[entry.source.name]
	    return vim_item
	end,
    },
    -- Cmp Sources
    sources = {
	{ name = "nvim_lsp" }
	{ name = "luasnip" }
    },
    confirm_opts = {
	behaviour = cmp.ConfirmBehaviour.Replace,
	select = false
    }, 
    experimental = {
	ghost_text = true,
	native_menu = false,
    },
}
