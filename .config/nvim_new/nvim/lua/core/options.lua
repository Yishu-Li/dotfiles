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
opt.breakindent = true

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
opt.confirm = true

-- Responsiveness
opt.updatetime = 250
opt.timeoutlen = 300

-- Scrolling
opt.scrolloff = 6
opt.sidescrolloff = 8

-- macOS system clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.autocomplete = true
opt.autocompletedelay = 80
opt.complete = { ".", "w", "b", "u" }
opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- Mouse
opt.mouse = "a"

-- Display invisible characters without making the buffer noisy
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Keep folds open by default; Treesitter will provide fold expressions.
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Native command-line completion
opt.wildmenu = true
opt.wildmode = "noselect:lastused,full"
opt.wildoptions = { "pum", "tagfile", "exacttext" }

vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})

-- Keep normal command history navigation with Up/Down.
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
