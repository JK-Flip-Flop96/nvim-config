-- Load and Ready indent-blankline
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then  
    return
end

-- Set vim options required for the plugin
vim.opt.list = true
vim.opt.listchars:append("space: ")

-- indent-blankline options
indent_blankline.setup {
    space_char_blankline = " ",
    show_end_of_line = false,
    show_current_context = true,
    show_current_context_start = true,
}
