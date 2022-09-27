local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {

  pickers = {
    live_grep = {
      additional_args = function(opts)
        return { "--hidden", "--no-ignore" }
      end
    },
    find_files = {
      find_command = { "rg", "--no-ignore", "--hidden", "--files", "-g", "!{**/node_modules/*,**/.git/*}" },
    },
  },

  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<CR>"] = actions.select_default,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
}

-- IFF in Rust project (Cargo.toml exists in root)
-- do not search through "target" dir
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("rustripgrep", { clear = true }),
  callback = function()
    local Path = require("plenary.path")
    local cargo_toml = Path:new(vim.fn.getcwd() .. "/Cargo.toml")

    if cargo_toml:exists() and cargo_toml:is_file() then
      telescope.setup {
        pickers = {
          find_files = {
            find_command = { "rg", "--no-ignore", "--hidden", "--files", "-g",
              "!{**/node_modules/*,**/.git/*,**/target/*}" },
          },
        },
      }
    end
  end
})
