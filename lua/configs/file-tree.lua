-- require the file tree and ensure that it's loaded
local file_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not file_tree_ok then
  return
end

nvim_tree.setup()
