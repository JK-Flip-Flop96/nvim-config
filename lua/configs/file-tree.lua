-- require the file tree and ensure that it's loaded
local file_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not file_tree_ok then
  return
end

nvim_tree.setup({
	renderer = {
		indent_markers = {
			enable = true,
			inline_arrows = true,
		},
		icons = {
			git_placement = "signcolumn",
			show = {
				folder_arrow = false,
			},
			glyphs = {
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "",
					deleted = "",
					ignored = "",
				}
			}
		}
	}
})
