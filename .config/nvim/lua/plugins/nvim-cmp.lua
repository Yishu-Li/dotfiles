return {
  -- Disable nvim-cmp
  { "hrsh7th/nvim-cmp", enabled = false },

  -- Use blink.cmp instead
  {
    "saghen/blink.cmp",
    main = "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "super-tab" },
      fuzzy = { implementation = "lua" },
      sources = {
        default = { "lsp", "path", "buffer", "snippets", "copilot" },
      },
    },
    opt_extend = { "sources.default" },
  },
}
