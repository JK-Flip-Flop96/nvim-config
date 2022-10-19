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
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
    Copilot = "" -- Extra Icon for Co-pilot suggestions
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
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-3), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(3), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c"}),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping {
	    	i = cmp.mapping.abort(),
	    	c = cmp.mapping.close(),
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
		    	local entry = cmp.get_selected_entry()
				if not entry then
			    	cmp.select_next_item({ behaviour = cmp.SelectBehavior.Select })
				else
					cmp.confirm()
				end
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>" ] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
    }),
    -- Cmp Formatting
    formatting = {
	fields = {"abbr", "kind", "menu"},
	format = function(entry, vim_item)
	    -- Set the icons defined above
	    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

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
