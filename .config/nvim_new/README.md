# nvim_new

A Neovim 0.12+ configuration for the macOS laptop, based on the lightweight Kuma/server config but with fewer platform constraints.

## Design

- Native `vim.pack` plugin management
- Native Neovim LSP completion
- `mason.nvim` + `mason-lspconfig.nvim` for language servers
- New `nvim-treesitter` main-branch API for parsers/highlighting
- `mini.pick` for file search, grep, buffers, and help (no Telescope)
- `mini.clue` for leader-key hints
- `mini.tabline`, `mini.statusline`, `mini.diff`, `mini.files`, `mini.surround`, `mini.pairs`
- `yazi.nvim` for the external file manager
- `conform.nvim` for formatting
- Catppuccin Latte
- `vim-tmux-navigator`
- No AI plugins
- No Jupyter/Quarto integration for now

## macOS dependencies

Install Homebrew packages:

```bash
brew install \
  neovim \
  ripgrep \
  fd \
  yazi \
  node \
  tree-sitter-cli \
  stylua \
  shfmt \
  coreutils
```

`tree-sitter-cli` is required by the current `nvim-treesitter` main branch. `coreutils` provides `grealpath`, used by some yazi.nvim path features on macOS.

Install Prettier for web/config/Markdown formatting:

```bash
npm install -g prettier
```

If command-line build tools are missing:

```bash
xcode-select --install
```

## Activate this config

The actual Neovim config is stored at:

```text
.config/nvim_new/nvim/
```

From the dotfiles repository root, back up the current config and symlink the new one:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
ln -s "$PWD/.config/nvim_new/nvim" ~/.config/nvim
```

If the dotfiles repository is not your current directory, replace `$PWD` with its absolute path.

To switch back:

```bash
rm ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim
```

## First launch

Start Neovim:

```bash
nvim
```

`vim.pack` will clone the configured plugins. Mason will install the configured language servers, including:

- lua_ls
- basedpyright
- ruff
- bashls
- yamlls
- jsonls
- html
- cssls
- ts_ls

Treesitter will install the parsers listed in `lua/core/treesitter.lua` asynchronously.

Useful checks:

```vim
:checkhealth
:checkhealth vim.lsp
:checkhealth nvim-treesitter
:checkhealth yazi
:Mason
:LspInfo
```

After updating `nvim-treesitter`, also update its parsers:

```vim
:TSUpdate
```

## Plugin updates

With Neovim 0.12 native package management:

```vim
:packupdate
```

The generated `nvim-pack-lock.json` should be committed to dotfiles if you want reproducible plugin revisions.

## Main keymaps

### Find / files

- `<leader>ff` — find files with mini.pick
- `<leader>fg` — live grep with mini.pick
- `<leader>fb` — buffers
- `<leader>fh` — help tags
- `<leader>fm` — mini.files

The included `ripgreprc` makes mini.pick include hidden files while excluding `.git`, `node_modules`, and macOS `Library` trees.

### Yazi

- `<leader>yz` — Yazi at current file
- `<leader>yw` — Yazi at current working directory
- `<C-Up>` — resume/toggle the last Yazi session

### Buffers

- `<leader>bn` — new buffer
- `<leader>bb` — pick buffer
- `<leader>bd` — delete buffer
- `<S-h>` / `<S-l>` — previous / next buffer
- `<S-BS>` — delete current buffer
- `<C-BS>` — close current window

### LSP

- `gd` — definition
- `gr` — references
- `K` — hover
- `<leader>rn` — rename
- `<leader>ca` — code action
- `<C-Space>` — manually trigger completion

### Formatting

- `<leader>cf` — format current buffer/range

Formatting also runs on save through Conform when a formatter is available.

## Why no Telescope?

`mini.pick` already covers the functions needed here: files, live grep, buffers, help, preview, fuzzy matching, and split/vsplit/tab opening. Yazi handles interactive file management. Telescope would mostly duplicate this functionality while adding another picker framework and dependencies, so this config intentionally stays with one picker.
