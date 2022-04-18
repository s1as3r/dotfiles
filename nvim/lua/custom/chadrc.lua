local M = {}

M.ui = {
   theme = "onedark",
}

M.plugins = {
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
}


return M
