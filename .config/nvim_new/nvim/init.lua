vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keep ripgrep behaviour local to this Neovim config.
vim.env.RIPGREP_CONFIG_PATH = vim.fn.stdpath("config") .. "/ripgreprc"

require("core.options")
require("core.plugins")
require("core.treesitter")
require("core.lsp")
require("core.format")
require("core.keymaps")
