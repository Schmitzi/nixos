local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Setup mason
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Setup mason-lspconfig
mason_lspconfig.setup({
  -- List of servers to install
  ensure_installed = {
    "lua_ls",        -- Lua
    "pyright",       -- Python
    "ts_ls",      -- TypeScript/JavaScript
    -- Add more servers as needed
  },
  automatic_installation = true,
})

-- Configure each language server
mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {}
  end,
  
  -- Special configurations for specific servers
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
}
