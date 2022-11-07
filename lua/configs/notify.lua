local api = vim.api
local base = require("notify.render.base")
local stages_util = require("notify.stages.util")

local function custom_render(bufnr, notif, highlights, config)
	local left_icon = notif.icon .. " "
	local max_message_width = math.max(math.max(unpack(vim.tbl_map(function(line)
		return vim.fn.strchars(line)
	end, notif.message))))
	local right_title = notif.title[2]
	local left_title = notif.title[1]
	local title_accum = vim.str_utfindex(left_icon)
		+ vim.str_utfindex(right_title)
		+ vim.str_utfindex(left_title)

	local left_buffer = string.rep(" ", math.max(0, max_message_width - title_accum))

	local namespace = base.namespace()
	api.nvim_buf_set_lines(bufnr, 0, 1, false, { "", "" })
	api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
		virt_text = {
			{ " ", highlights.title },
			{ left_icon, highlights.icon },
			{ left_title .. left_buffer, highlights.title },
		},
		virt_text_win_col = 0,
		priority = 10,
	})
	api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
		virt_text = { { " ", highlights.title }, { right_title, highlights.title }, { " ", highlights.title } },
		virt_text_pos = "right_align",
		priority = 10,
	})
	api.nvim_buf_set_extmark(bufnr, namespace, 1, 0, {
		virt_text = {
			{
				string.rep(" ", math.max(vim.str_utfindex(left_buffer) + title_accum + 2, config.minimum_width())),
				highlights.border,
			},
		},
		virt_text_win_col = 0,
		priority = 10,
	})
	api.nvim_buf_set_lines(bufnr, 2, -1, false, notif.message)
	api.nvim_buf_set_extmark(bufnr, namespace, 2, 0, {
		hl_group = highlights.body,
		end_line = 1 + #notif.message,
		end_col = #notif.message[#notif.message],
		priority = 50,
	})
end

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
	},
	render = custom_render
})
