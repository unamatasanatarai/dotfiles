local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
  diagnostics.shellcheck,
  code_actions.shellcheck,
  --  formatting.eslint,
  formatting.black,
  formatting.shellharden.with({
    filetypes = { 'sh' }
  }),
  formatting.prettier.with({
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "json",
      "jsonc",
      "yaml",
      "markdown",
      "graphql",
      "handlebars",
    }
  }),
  formatting.shfmt.with({
    extra_args = {
      "-i",
      "2",
      "-ci",
      "-p"
    }
  }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
