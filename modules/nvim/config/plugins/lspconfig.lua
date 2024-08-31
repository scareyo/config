local lsp_config = require("lspconfig")

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = false,
})

-- Show diagnostics on hover
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

-- C#
lsp_config.omnisharp.setup{}

-- Go
lsp_config.gopls.setup{}

-- Lua
lsp_config.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Nix
lsp_config.nil_ls.setup{}

-- Rust
lsp_config.rust_analyzer.setup{}
