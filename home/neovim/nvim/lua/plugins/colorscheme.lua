return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = function()
      local gruvbox = require("gruvbox")
      local p = gruvbox.palette
      return {
        contrast = "hard",
        overrides = {
          FloatBorder = { bg = "NONE" },
          CmpItemMenu = { italic = true },
          -- Invert cmp highlighting
          CmpItemKindText = { bg = p.bright_orange, fg = p.light0 },
          CmpItemKindVariable = { bg = p.bright_orange, fg = p.light0 },
          CmpItemKindMethod = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindFunction = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindConstructor = { bg = p.bright_yellow, fg = p.light0 },
          CmpItemKindUnit = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindField = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindClass = { bg = p.bright_yellow, fg = p.light0 },
          CmpItemKindInterface = { bg = p.bright_yellow, fg = p.light0 },
          CmpItemKindModule = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindProperty = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindValue = { bg = p.bright_orange, fg = p.light0 },
          CmpItemKindEnum = { bg = p.bright_yellow, fg = p.light0 },
          CmpItemKindOperator = { bg = p.bright_yellow, fg = p.light0 },
          CmpItemKindKeyword = { bg = p.bright_purple, fg = p.light0 },
          CmpItemKindEvent = { bg = p.bright_purple, fg = p.light0 },
          CmpItemKindReference = { bg = p.bright_purple, fg = p.light0 },
          CmpItemKindColor = { bg = p.bright_purple, fg = p.light0 },
          CmpItemKindSnippet = { bg = p.bright_green, fg = p.light0 },
          CmpItemKindFile = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindFolder = { bg = p.bright_blue, fg = p.light0 },
          CmpItemKindEnumMember = { bg = p.bright_aqua, fg = p.light0 },
          CmpItemKindConstant = { bg = p.bright_orange, fg = p.light0 },
          CmpItemKindStruct = { bg = p.bright_yellow, fg = p.light0 },
          CmpItemKindTypeParameter = { bg = p.bright_yellow, fg = p.light0 },
        }
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
