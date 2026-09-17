require("mason").setup({
  ui = {
    border = "rounded",
  },
})

-- ------------------------------------------------------------
-- Per-server settings using the Neovim 0.12 LSP API
-- ------------------------------------------------------------

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Mason installs these servers and mason-lspconfig enables them through
-- vim.lsp.enable(). No old require("lspconfig").xxx.setup() calls are needed.
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "basedpyright",
    "ruff",
    "bashls",
    "yamlls",
    "jsonls",
    "html",
    "cssls",
    "ts_ls",
  },
  automatic_enable = true,
})

-- ------------------------------------------------------------
-- Diagnostics
-- ------------------------------------------------------------

vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = true,
  },
})

-- ------------------------------------------------------------
-- Native Neovim completion
-- ------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("desktop-lsp", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      -- Make native completion behave more like a full completion plugin by
      -- allowing printable characters to retrigger completion.
      local provider = client.server_capabilities.completionProvider
      if provider then
        local chars = {}
        for i = 32, 126 do
          table.insert(chars, string.char(i))
        end
        provider.triggerCharacters = chars
      end

      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
      })
    end
  end,
})

vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, {
  desc = "LSP completion",
})

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
