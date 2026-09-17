local map = vim.keymap.set

-- ------------------------------------------------------------
-- General
-- ------------------------------------------------------------

map("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlight",
})

map("n", "<leader>w", "<cmd>write<CR>", {
  desc = "Save",
})

map("n", "<leader>q", "<cmd>quit<CR>", {
  desc = "Quit",
})

-- ------------------------------------------------------------
-- Buffers / windows
-- ------------------------------------------------------------

map("n", "<S-BS>", function()
  vim.api.nvim_buf_delete(0, { force = false })
end, {
  desc = "Delete buffer",
})

map("n", "<C-BS>", "<cmd>close<CR>", {
  desc = "Close window",
})

map("n", "<leader>bn", "<cmd>enew<CR>", {
  desc = "New buffer",
})

map("n", "<leader>bd", function()
  vim.api.nvim_buf_delete(0, { force = false })
end, {
  desc = "Delete buffer",
})

map("n", "<leader>bb", function()
  MiniPick.builtin.buffers()
end, {
  desc = "Buffers",
})

map("n", "<S-l>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

map("n", "<S-h>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})

-- ------------------------------------------------------------
-- Neovim / tmux pane navigation
-- ------------------------------------------------------------

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")

-- ------------------------------------------------------------
-- mini.pick
-- RIPGREP_CONFIG_PATH is set in init.lua, so hidden files are included while
-- .git is excluded for both file search and grep.
-- ------------------------------------------------------------

map("n", "<leader>ff", function()
  MiniPick.builtin.files()
end, {
  desc = "Find files",
})

map("n", "<leader>fg", function()
  MiniPick.builtin.grep_live()
end, {
  desc = "Live grep",
})

map("n", "<leader>fb", function()
  MiniPick.builtin.buffers()
end, {
  desc = "Buffers",
})

map("n", "<leader>fh", function()
  MiniPick.builtin.help()
end, {
  desc = "Help",
})

-- Lightweight file browser inside Neovim.
map("n", "<leader>fm", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    path = vim.uv.cwd()
  end
  MiniFiles.open(path, true)
end, {
  desc = "Mini files",
})

-- ------------------------------------------------------------
-- Yazi
-- ------------------------------------------------------------

map({ "n", "v" }, "<leader>yz", "<cmd>Yazi<CR>", {
  desc = "Yazi current file",
})

map("n", "<leader>yw", "<cmd>Yazi cwd<CR>", {
  desc = "Yazi working directory",
})

map("n", "<C-Up>", "<cmd>Yazi toggle<CR>", {
  desc = "Resume Yazi",
})

-- ------------------------------------------------------------
-- Diagnostics
-- ------------------------------------------------------------

map("n", "<leader>e", vim.diagnostic.open_float, {
  desc = "Diagnostic",
})

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, {
  desc = "Previous diagnostic",
})

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, {
  desc = "Next diagnostic",
})

-- ------------------------------------------------------------
-- LSP
-- ------------------------------------------------------------

map("n", "gd", vim.lsp.buf.definition, {
  desc = "Go to definition",
})

map("n", "gr", vim.lsp.buf.references, {
  desc = "References",
})

map("n", "K", vim.lsp.buf.hover, {
  desc = "Hover documentation",
})

map("n", "<leader>rn", vim.lsp.buf.rename, {
  desc = "Rename",
})

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
  desc = "Code action",
})

-- ------------------------------------------------------------
-- Formatting
-- ------------------------------------------------------------

map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
  })
end, {
  desc = "Format",
})
