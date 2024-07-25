return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<M-n>", false }
    return vim.tbl_deep_extend("force", opts, {
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
        nixd = {
          cmd = { "nixd" },
          settings = {
            nixd = {
              nixkgs = { expr = "import <nixpkgs> {}" },
              formatting = { command = { "nixfmt" } },
              options = {
                nixos = { expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.atlas.options', },
                -- home_manager = { expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ved".options', },
              },
            },
          }
        },
        astro = {},
        typst_lsp = {
          root_dir = function()
            return vim.fn.getcwd()
          end,
        },
        ruff_lsp = {},
        ocamllsp = {},
        zls = {
          cmd = { "/home/ved/code/zls/zig-out/bin/zls" },
          settings = {
            zls = {
              path = "/home/ved/code/zls/zig-out/bin/zls",
              enable_snippets = true,
              enable_ast_check_diagnostics = true,
              enable_autofix = true,
              enable_import_embedfile_argument_completions = true,
              warn_style = true,
              enable_semantic_tokens = true,
              enable_inlay_hints = true,
              inlay_hints_hide_redundant_param_names = true,
              inlay_hints_hide_redundant_param_names_last_token = true,
              operator_completions = true,
              include_at_in_builtins = true,
              max_detail_length = 1048576,
            }
          },
        },
      },
    })
  end,
}
