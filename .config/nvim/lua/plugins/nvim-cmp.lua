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
      keymap = {
        preset = "super-tab",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      fuzzy = { implementation = "lua" },
      sources = {
        default = { "lsp", "path", "buffer", "snippets", "copilot" },
        providers = {
          path = {
            -- Only suppress path completion for CopilotChat *slash commands* at BOL.
            enabled = function()
              if vim.bo.filetype ~= "copilot-chat" then
                return true
              end
              local line = vim.api.nvim_get_current_line()
              local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-based
              local before = line:sub(1, col)

              -- If we're currently typing a slash command like "/he|"
              -- at the start of the line, disable path completion.
              if before:match("^/%w*$") then
                return false
              end

              -- Otherwise (e.g. "#file ./src/…"), keep path completion ON.
              return true
            end,
          },
        },
      },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
      completion = {
        keyword = { range = "full" },
      },
    },
    opt_extend = { "sources.default" },
  },
}
