--[[
 https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
--]]
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
  --[[
  BASH
  --]]
  code_actions.shellcheck,
  formatting.shellharden.with({
    filetypes = { 'sh' }
  }),
  formatting.shfmt.with({
    extra_args = {
      "-i",
      "2",
      "-ci",
      "-sr",
      "-ln",
      "bash",
      "-bn",
      "-sr",
    }
  }),
  --[[
  MAKEFILE
  --]]
  diagnostics.checkmake,
  formatting.taplo,
}

null_ls.setup({
  debug = true,
  sources = sources,
})
