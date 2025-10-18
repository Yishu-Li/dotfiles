-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Shift + Backspace → 关闭 buffer（不关闭窗口）
vim.keymap.set("n", "<S-BS>", function()
  require("mini.bufremove").delete(0, false)
end, { noremap = true, silent = true })

-- Ctrl + Backspace → 关闭窗口
map("n", "<C-BS>", ":close<CR>", opts)
