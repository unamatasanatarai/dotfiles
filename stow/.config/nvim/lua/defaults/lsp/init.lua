local servers = {
  ["bashls"] = {},
  --  "eslint",
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
  --  "jsonls",
  --  "marksman",
  --  "stylelint_lsp",
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
  --  "svelte",
  --  "tsserver",
}

--require("lspconfig")["marksman"].setup({
--  on_attach = on_attach,
--  flags = lsp_flags,
--  root_dir = require("lspconfig/util").root_pattern(".git", ".marksman.toml", "*.md"),
--})
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>et', "<cmd>Telescope diagnostics<cr>", opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- todo: do we really need this? does this not slow down the bootup?
local lsp_installer = require("nvim-lsp-installer")
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end


for name, options in pairs(servers) do
  options.on_attach = on_attach
  options.flags = lsp_flags
  require("lspconfig")[name].setup(options)
end


-- todo: refactor, move to another location possibly
local function lsp_install_servers()
  vim.api.nvim_command("LspInstall " .. table.concat(servers, " "))
end

vim.api.nvim_create_user_command('LspInstallServers', lsp_install_servers, {})
