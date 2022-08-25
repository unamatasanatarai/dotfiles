local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

local sources = {
  formatting.eslint,
  formatting.black,
  formatting.stylelint,
  formatting.shfmt.with({extra_args={"-i", "2"} }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
