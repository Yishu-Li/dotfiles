local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false

-- Editing
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Windows
opt.splitbelow = true
opt.splitright = true

-- Files
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Responsiveness
opt.updatetime = 250
opt.timeoutlen = 300

-- Scrolling
opt.scrolloff = 6
opt.sidescrolloff = 8

-- Completion
opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- Mouse works well through modern SSH terminals
opt.mouse = "a"

-- System clipboard may not exist on a headless HPC machine,
-- so deliberately do NOT set clipboard=unnamedplus.

-- We are deliberately using classic syntax instead of external
-- tree-sitter parsers on Kuma.
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")


-- ------------------------------------------------------------
-- Native command-line completion
-- ------------------------------------------------------------

vim.opt.wildmenu = true
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = {
  "pum",
  "tagfile",
  "exacttext",
}

vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})

-- Keep normal command history navigation with Up/Down
vim.keymap.set("c", "<Up>", function()
  if vim.fn.wildmenumode() == 1 then
    return "<C-E><Up>"
  end
  return "<Up>"
end, { expr = true })

vim.keymap.set("c", "<Down>", function()
  if vim.fn.wildmenumode() == 1 then
    return "<C-E><Down>"
  end
  return "<Down>"
end, { expr = true })


-- ------------------------------------------------------------
-- Native insert mode completion
-- ------------------------------------------------------------
vim.opt.autocomplete = true
vim.opt.autocompletedelay = 100

vim.opt.complete = {
  ".",   -- current buffer
  "w",   -- other windows
  "b",   -- other loaded buffers
  "u",   -- unloaded buffers
}

vim.opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
  "popup",
}
