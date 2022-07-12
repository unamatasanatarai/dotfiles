local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "php",
    "python",
    "scss",
    "typescript",
    "yaml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autopairs = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  indent = { enable = true, disable = { } },
})
