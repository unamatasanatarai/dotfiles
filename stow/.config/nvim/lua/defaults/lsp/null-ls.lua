local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

local sources = {
  --  formatting.eslint,
  formatting.black,
  formatting.prettier.with({ filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css",
    "scss", "less", "json", "jsonc", "yaml", "markdown", "graphql", "handlebars" } }),
  formatting.shfmt.with({ extra_args = { "-i", "2" } }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
