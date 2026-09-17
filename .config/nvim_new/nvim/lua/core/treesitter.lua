local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
  return
end

local parsers = {
  -- Neovim
  "lua",
  "vim",
  "vimdoc",
  "query",

  -- Research / scripting
  "python",
  "bash",

  -- Config
  "json",
  "yaml",
  "toml",

  -- Markdown
  "markdown",
  "markdown_inline",

  -- Web / general development
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",

  -- Git / misc
  "gitcommit",
  "gitignore",
  "diff",
  "regex",
}

-- nvim-treesitter main branch uses its new 0.12-era API.
-- Already installed parsers are skipped.
ts.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("desktop-treesitter", { clear = true }),
  callback = function(args)
    local started = pcall(vim.treesitter.start, args.buf)
    if not started then
      return
    end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})
