local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

if not dap_ok and dapui_ok then
  return
end

dapui.setup()

-- Adapters
require "configs.dap.adapters.debugpy"
