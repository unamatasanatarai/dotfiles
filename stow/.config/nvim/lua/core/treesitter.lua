local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    --    "css",
    --    "html",
    --    "javascript",
    --    "json",
    "lua",
    --    "make",
    "markdown",
    --    "php",
    --    "python",
    --    "scss",
    --    "svelte",
    --    "typescript",
    --    "yaml",
  },
  auto_install = true,
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
  indent = {
    enable = true
  },
})
