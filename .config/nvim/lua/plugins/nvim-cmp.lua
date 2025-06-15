-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        -- Tab 键确认补全
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true }) -- 确认选中项
          else
            fallback() -- 默认 Tab 行为（如缩进）
          end
        end, { "i", "s" }),

        -- 禁用回车补全，强制回车仅换行
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              -- 关闭补全菜单但不确认选择
              cmp.abort()
            end
            -- 插入普通回车（换行）
            fallback()
          end,
        }),
      })
      return opts
    end,
  },
}
