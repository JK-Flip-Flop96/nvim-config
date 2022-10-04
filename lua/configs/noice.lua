local noice_status, noice = pcall(require, 'noice')
if not noice_status then
  return
end

noice.setup({
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
				style = "single",
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "Normal" }
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
				style = "single",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }
			}
		}
	}
})

