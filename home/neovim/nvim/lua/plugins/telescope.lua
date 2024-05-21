return {
  {
    "telescope.nvim",
    opts = {
      -- pickers = {
      --   find_files = {
      --     theme = "ivy",
      --   },
      --   git_files = {
      --     theme = "ivy",
      --   },
      --   live_grep = {
      --     theme = "ivy",
      --   },
      -- },
      defaults = {
        prompt_prefix = "  ",
        -- selection_caret = "  ",
        -- entry_prefix = "  ",
        set_env = { ["COLORTERM"] = "truecolor" },
        dynamic_preview_title = true,
      },
    },
  },
}
