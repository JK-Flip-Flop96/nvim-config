local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

vim.opt.fillchars:append { eob = " " }

vim.cmd [[ au User AlphaReady if winnr('$') == 1 | set laststatus=1 ]]


dashboard.section.buttons.val = {
	dashboard.button("n", "  Create New file",       ":set laststatus=3 | :ene <BAR> startinsert <CR>"),
	dashboard.button("e", "  Open File Manager",     ":set laststatus=3 | :NvimTreeOpen <CR>"),
    dashboard.button("v", "  Neovim Settings ",      ":set laststatus=3 | e ~/Appdata/Local/nvim/init.lua <CR>"),
	dashboard.button("u", "  Update Nvim Plugins",   ":PackerUpdate <CR>"),
	dashboard.button("q", "  Quit Neovim",           ":qa<CR>"),
}

dashboard.section.header.val = {
    [[__/\\\\\_____/\\\___________________________________________________________________________        ]],        
    [[ _\/\\\\\\___\/\\\___________________________________________________________________________       ]],
    [[  _\/\\\/\\\__\/\\\_________________________________________________/\\\______________________      ]],
    [[   _\/\\\//\\\_\/\\\______/\\\\\\\\_______/\\\\\______/\\\____/\\\__\///______/\\\\\__/\\\\\___     ]],
    [[    _\/\\\\//\\\\/\\\____/\\\/////\\\____/\\\///\\\___\//\\\__/\\\____/\\\___/\\\///\\\\\///\\\_    ]],
    [[     _\/\\\_\//\\\/\\\___/\\\\\\\\\\\____/\\\__\//\\\___\//\\\/\\\____\/\\\__\/\\\_\//\\\__\/\\\_   ]],
    [[      _\/\\\__\//\\\\\\__\//\\///////____\//\\\__/\\\_____\//\\\\\_____\/\\\__\/\\\__\/\\\__\/\\\_  ]],
    [[       _\/\\\___\//\\\\\___\//\\\\\\\\\\___\///\\\\\/_______\//\\\______\/\\\__\/\\\__\/\\\__\/\\\_ ]],
    [[        _\///_____\/////_____\//////////______\/////__________\///_______\///___\///___\///___\///__]],
}


dashboard.section.footer.val = {
    "Config by Stuart Miller 2022",
}

-- Layout For Luavim ascii art
dashboard.config.layout = {
    { type = "padding", val = 5 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
}

alpha.setup(dashboard.opts)