return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "quarto",
    },
  },

  {
    "3rd/image.nvim",
    build = false, -- 如果遇到编译错误，可以尝试设为 true
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto", "melton" },
        },
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
    },
  },

  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          chunks = "all",
          languages = { "python" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
          ft_runners = { python = "molten" },
        },
        keymap = {
          hover = "K",
          definition = "gd",
        },
      })

      local runner = require("quarto.runner")
      vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "Run Cell", silent = true })
      vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "Run Above", silent = true })
      vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "Run All", silent = true })
      vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "Run Visual", silent = true })
      vim.keymap.set("n", "]c", function()
        vim.fn.search([[^```\s*\S]], "W")
      end, { desc = "Next cell" })

      vim.keymap.set("n", "[c", function()
        vim.fn.search([[^```\s*\S]], "bW")
      end, { desc = "Last cell" })
    end,
  },

  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,

    keys = {
      { "<leader>os", ":noautocmd MoltenEnterOutput<CR>", desc = "Output show" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "python",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "query",
      })
    end,
  },

  {
    "jmbuhr/otter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "quarto" }, -- 仅在这些文件中开启
    config = function()
      require("headlines").setup({
        quarto = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
              (fenced_code_block) @codeblock
            ]]
          ),
          codeblock_highlight = "CodeBlock", -- 代码块背景高亮
          treesitter_language = "markdown",
        },
        markdown = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
              (fenced_code_block) @codeblock
            ]]
          ),
          codeblock_highlight = "CodeBlock",
        },
      })

      -- Color preview --> :hi CodeBlock guibg=#d0d0d0
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#d0d0d0" })
    end,
  },
}
