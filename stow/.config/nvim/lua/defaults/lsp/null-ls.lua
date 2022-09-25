local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
  -- BASH
  diagnostics.shellcheck,
  code_actions.shellcheck,
  formatting.shellharden.with({
    filetypes = { 'sh' }
  }),
  formatting.beautysh.with({
    extra_args = {
      "-i",
      "2",
      "-s",
      "fnonly"
    }
  }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
