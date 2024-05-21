return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = {
      enabled = true,
    },
    --@type lspconfig.options
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enabled = true }
          }
        }
      },
      nil_ls = {},
      astro = {},
      typst_lsp = {
        root_dir = function()
          return vim.fn.getcwd()
        end,
      },
      ruff_lsp = {},
      ocamllsp = {},
      -- TODO: basedpyright
      -- pyright = {},
    },
  },
}
