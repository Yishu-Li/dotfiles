-- ------------------------------------------------------------
-- Enable language servers only if their executables exist.
--
-- Important for HPC:
-- do not let Neovim/Mason download random precompiled binaries.
-- Use tools already installed in your project/user environment.
-- ------------------------------------------------------------

local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Python
if executable("basedpyright-langserver") then
  vim.lsp.enable("basedpyright")
elseif executable("pyright-langserver") then
  vim.lsp.enable("pyright")
end

if executable("ruff") then
  vim.lsp.enable("ruff")
end

-- Lua
if executable("lua-language-server") then
  vim.lsp.enable("lua_ls")
end

-- Bash
if executable("bash-language-server") then
  vim.lsp.enable("bashls")
end

-- YAML
if executable("yaml-language-server") then
  vim.lsp.enable("yamlls")
end

-- JSON
if executable("vscode-json-language-server") then
  vim.lsp.enable("jsonls")
end

-- HTML
if executable("vscode-html-language-server") then
  vim.lsp.enable("html")
end

-- CSS
if executable("vscode-css-language-server") then
  vim.lsp.enable("cssls")
end

-- ESLint
if executable("vscode-eslint-language-server") then
  vim.lsp.enable("eslint")
end

-- ------------------------------------------------------------
-- Native Neovim LSP completion
-- ------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kuma-lsp", { clear = true }),

  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      -- Make native LSP completion behave more like blink.cmp:
      -- trigger completion on normal printable characters too.
      local chars = {}

      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end

      client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(
        true,
        client.id,
        ev.buf,
        {
          autotrigger = true,
        }
      )
    end
  end,
})


-- Manually trigger LSP completion.
vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, {
  desc = "LSP completion",
})

-- Navigate completion popup with Tab.
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end

  return "<Tab>"
end, {
  expr = true,
})

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end

  return "<S-Tab>"
end, {
  expr = true,
})
