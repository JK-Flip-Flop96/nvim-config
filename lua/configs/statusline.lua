-- Load and Ready LuaLine
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local config = {
    options = {
        globalstatus = true,
        component_separators = '',
        section_separators = '',
        theme = 'base16',
    },
}

lualine.setup(config)

vim.opt.laststatus = 3