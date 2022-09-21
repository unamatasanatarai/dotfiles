function StatusLine()
  return table.concat {
    "%f",
    " %m",
    "%=",
    "%l:%-6c",
    " %y ",
    vim.api.nvim_get_mode().mode,
    " "
  }
end

vim.opt.statusline = "%!luaeval('StatusLine()')"
