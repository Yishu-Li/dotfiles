vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.nvim",
    version = "stable",
  },
  {
    src = "https://github.com/neovim/nvim-lspconfig",
  },
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
  {
    src = "https://github.com/christoomey/vim-tmux-navigator",
  },
})

-- ------------------------------------------------------------
-- mini.nvim
-- ------------------------------------------------------------

require("mini.icons").setup()
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.diff").setup()
require("mini.tabline").setup()
require("mini.files").setup()

local clue = require("mini.clue")
clue.setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "n", keys = "g" },
    { mode = "n", keys = "z" },
    { mode = "n", keys = "<C-w>" },
    { mode = "n", keys = "s" },
    { mode = "x", keys = "s" },
  },

  clues = {
    { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
    { mode = "n", keys = "<Leader>f", desc = "+Find" },
    { mode = "n", keys = "<Leader>c", desc = "+Code" },
    { mode = "n", keys = "<Leader>r", desc = "+Refactor" },

    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
  },

  window = {
    delay = 200,
  },
})

-- ------------------------------------------------------------
-- Colorscheme
-- ------------------------------------------------------------

require("catppuccin").setup({
  flavour = "latte",
})

vim.cmd.colorscheme("catppuccin")
