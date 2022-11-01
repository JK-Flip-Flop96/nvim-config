local stages_util = require("notify.stages.util")

require('notify').setup({
	background_colour = "Normal",
	fps = 60,
	stages = {
		function(state)
			local next_height = state.message.height + 2

			-- Add 1 to the row number to account for the winbar
			local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.TOP_DOWN) + 1
			if not next_row then
				return nil
			end
			return {
        		relative = "editor",
        		anchor = "NE",
    			width = state.message.width,
				height = state.message.height,
				col = vim.opt.columns:get(),
    			row = next_row,
    			border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
    			style = "minimal",
			}
		end,
    	function()
			return {
    		col = { vim.opt.columns:get() },
        		time = true,
			}
		end,
	}
})


