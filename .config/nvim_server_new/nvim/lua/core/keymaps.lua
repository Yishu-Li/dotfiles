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
-- Your existing buffer/window behaviour
-- ------------------------------------------------------------

map("n", "<S-BS>", function()
  vim.api.nvim_buf_delete(0, { force = false })
end, {
  desc = "Delete buffer",
})

map("n", "<C-BS>", "<cmd>close<CR>", {
  desc = "Close window",
})

-- New empty buffer
map("n", "<leader>bn", "<cmd>enew<CR>", {
  desc = "New buffer",
})

-- Next / previous buffer
map("n", "<S-l>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

map("n", "<S-h>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})

-- Pick an existing buffer
map("n", "<leader>bb", function()
  MiniPick.builtin.buffers()
end, {
  desc = "Buffers",
})

-- Delete current buffer
map("n", "<leader>bd", function()
  vim.api.nvim_buf_delete(0, { force = false })
end, {
  desc = "Delete buffer",
})

-- ------------------------------------------------------------
-- Window navigation
--
-- vim-tmux-navigator makes these work across both Neovim
-- splits and tmux panes.
-- ------------------------------------------------------------

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")

-- ------------------------------------------------------------
-- mini.pick
-- ------------------------------------------------------------

map("n", "<leader>ff", function()
  local files = vim.fn.systemlist({
    "rg",
    "--files",
    "--hidden",
    "--glob",
    "!.git/*",
  })

  MiniPick.start({
    source = {
      items = files,
      name = "Files",
      cwd = vim.fn.getcwd(),
    },
  })
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

map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, {
  desc = "Format",
})
