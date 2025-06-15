-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal 模式：Tab / Shift+Tab 缩进当前行
map("n", "<Tab>", ">>_", opts)
map("n", "<S-Tab>", "<<_", opts)

-- Visual 模式：缩进选中行并保持选中状态
map("v", "<Tab>", ">gv", opts)
map("v", "<S-Tab>", "<gv", opts)

-- 插入模式下：Shift+Tab 缩进回退（模拟 Ctrl-D）
map("i", "<S-Tab>", "<C-d>", opts)

-- Shift + Backspace → 关闭 buffer（不关闭窗口）
vim.keymap.set("n", "<S-BS>", function()
  require("mini.bufremove").delete(0, false)
end, { noremap = true, silent = true })

-- Ctrl + Backspace → 关闭窗口
map("n", "<C-BS>", ":close<CR>", opts)

-- Select jupyter kernel
vim.keymap.set("n", "<localleader>ip", function()
  local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
  if venv ~= nil then
    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd("MoltenInit python3")
  end
end, { desc = "Initialize Molten for python3", silent = true })
