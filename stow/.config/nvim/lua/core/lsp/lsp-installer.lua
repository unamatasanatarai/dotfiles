--[[
 https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--]]
local servers = {
  ["bashls"] = {},
  ["jsonls"] = {},
  ["rust_analyzer"] = {},
  ["html"] = {
    settings = {
      html = {
        format = {
          templating = true,
          wrapLineLength = 120,
          wrapAttributes = 'auto',
        },
        hover = {
          documentation = true,
          references = true,
        },
      },
    },
  },
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        telemetry = {
          enable = false
        }
      }
    }
  },
  ["marksman"] = {
    root_dir = require("lspconfig/util").root_pattern(".git", ".marksman.toml", "*.md"),
  },
  ["phan"] = {},
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- setup
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

for name, options in pairs(servers) do
  options.on_attach = on_attach
  options.flags = lsp_flags
  require("lspconfig")[name].setup(options)
end
