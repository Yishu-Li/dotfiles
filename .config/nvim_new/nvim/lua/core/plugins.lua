local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  -- Core UI/editing toolkit
  { src = gh("nvim-mini/mini.nvim"), version = "stable" },

  -- LSP/tool management
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("mason-org/mason-lspconfig.nvim") },

  -- Syntax/tree parsing
  { src = gh("nvim-treesitter/nvim-treesitter") },

  -- Formatting
  { src = gh("stevearc/conform.nvim") },

  -- File manager integration
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("mikavilpas/yazi.nvim") },

  -- UI
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  { src = gh("j-hui/fidget.nvim") },

  -- Seamless navigation when Neovim is inside tmux
  { src = gh("christoomey/vim-tmux-navigator") },
}, { confirm = false })

-- ------------------------------------------------------------
-- mini.nvim
-- ------------------------------------------------------------

local icons = require("mini.icons")
icons.setup()
icons.mock_nvim_web_devicons()

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
    { mode = "n", keys = "<Leader>c", desc = "+Code" },
    { mode = "n", keys = "<Leader>f", desc = "+Find / Files" },
    { mode = "n", keys = "<Leader>r", desc = "+Refactor" },
    { mode = "n", keys = "<Leader>y", desc = "+Yazi" },

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
-- Yazi
-- ------------------------------------------------------------

require("yazi").setup({
  open_for_directories = false,
  floating_window_scaling_factor = 0.9,
  yazi_floating_window_winblend = 0,
  yazi_floating_window_border = "rounded",
})

-- ------------------------------------------------------------
-- LSP progress UI
-- ------------------------------------------------------------

require("fidget").setup({})

-- ------------------------------------------------------------
-- Colorscheme
-- ------------------------------------------------------------

require("catppuccin").setup({
  flavour = "latte",
})

vim.cmd.colorscheme("catppuccin")
