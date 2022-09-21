function StatusLine()
  return table.concat {
    "%f",
    " %m",
    "%=",
    "%l:%-6c",
    vim.api.nvim_buf_get_option(0, 'filetype'),
    " ",
    vim.api.nvim_get_mode().mode,
    " ",
  }
end

vim.opt.statusline = "%!luaeval('StatusLine()')"
