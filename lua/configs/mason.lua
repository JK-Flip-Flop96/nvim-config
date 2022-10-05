local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

-- Mason setup
mason.setup({
    ui = {
	border = "none",
	icons = {
	    server_installed = "",
	    server_pending = "",
	    server_uninstalled = ""
	}
    }
})

-- Mason LSPConfig setup
mason_lspconfig.setup()
