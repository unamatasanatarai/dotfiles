local status_ok, todo = pcall(require, "nvim-md-todo-toggle")
if not status_ok then
  return
end

todo.setup {
  marker = "x"
}

vim.keymap.set("n", "<leader>t", todo.toggle, { desc = "Toggle a readme marker", noremap = true, silent = true })
