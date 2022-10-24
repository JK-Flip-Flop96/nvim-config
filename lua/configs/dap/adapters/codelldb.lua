local dap = require('dap')

dap.adapters.lldb = {
  	type = 'executable',
	command = '~/.local/share/nvim/mason/packages/codelldb/codelldb',
  	name = 'lldb'
}

dap.configurations.cpp = {
	{
		type = 'lldb',
		name = 'Launch',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {}
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
