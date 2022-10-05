local noice_status, noice = pcall(require, 'noice')
if not noice_status then
  return
end

noice.setup({
	popupmenu = {
		enable = false,
		backend = 'cmp',
	},
	views = {
		cmdline_popup = {
			position = {
				row = 5,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
			border = {
				style = "none",
				padding = { 1, 2 }
			},
			win_options = {
				winhighlight = { Normal = "NormalFloat", FloatBorder = "NormalFloat" }
			}
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 8,
				col = "50%",
			},
			size = {
				width = 60,
				height = 10,
			},
			border = {
				style = "none",
				padding = { 1, 2 },
			},
			win_options = {
				winhighlight = { Normal = "NormalFloat", FloatBorder = "NormalFloat" }
			}
		}
	}
})

