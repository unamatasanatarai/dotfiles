local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "cmake",
    "help",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "rust",
    "vim",
  },
  auto_install = false,
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
