_: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.theme = "no-clown-fiesta";

    # Ported from no-clown-fiesta.nvim (dark palette, highlight + treesitter groups).
    themes.no-clown-fiesta = {
      attribute = "fg";
      type = "fg";
      constructor = "cyan";
      constant = "fg";
      "constant.builtin" = "red";
      "constant.character" = "green";
      "constant.character.escape" = "medium_gray_blue";
      "constant.numeric" = "red";
      string = "medium_gray_blue";
      "string.special.path" = "light_gray";
      "string.special.url" = "light_gray";
      "string.special.symbol" = "medium_gray";
      comment = "medium_gray";
      variable = "fg";
      label = "fg";
      punctuation = "fg";
      keyword = "gray_blue";
      "keyword.control.import" = "red";
      "keyword.control.exception" = "red";
      "keyword.directive" = "red";
      operator = "fg";
      function = "cyan";
      tag = "blue";
      namespace = "fg";
      special = "fg";

      "markup.heading" = "blue";
      "markup.heading.marker" = "red";
      "markup.list" = "red";
      "markup.bold" = {
        fg = "yellow";
        modifiers = [ "bold" ];
      };
      "markup.italic".modifiers = [ "italic" ];
      "markup.strikethrough".modifiers = [ "crossed_out" ];
      "markup.link.url" = {
        fg = "cyan";
        modifiers = [ "underlined" ];
      };
      "markup.link.text" = "blue";
      "markup.quote" = "medium_gray";
      "markup.raw" = "green";

      "diff.plus" = "sign_add";
      "diff.minus" = "sign_delete";
      "diff.delta" = "sign_change";

      "ui.background".bg = "bg";
      "ui.text" = "fg";
      "ui.text.focus".bg = "alt_bg";
      "ui.text.inactive" = "medium_gray";
      "ui.cursor" = {
        fg = "cursor_fg";
        bg = "cursor_bg";
      };
      "ui.cursor.match" = {
        fg = "blue";
        modifiers = [ "underlined" ];
      };
      "ui.cursorline.primary".bg = "alt_bg";
      "ui.selection".bg = "gray";
      "ui.linenr" = "medium_gray";
      "ui.linenr.selected" = {
        fg = "light_gray";
        modifiers = [ "bold" ];
      };
      "ui.statusline" = {
        fg = "fg";
        bg = "alt_bg";
      };
      "ui.statusline.inactive" = {
        fg = "gray";
        bg = "alt_bg";
      };
      "ui.statusline.normal" = {
        fg = "cursor_bg";
        bg = "accent";
        modifiers = [ "bold" ];
      };
      "ui.statusline.insert" = {
        fg = "accent";
        bg = "cursor_bg";
        modifiers = [ "bold" ];
      };
      "ui.statusline.select" = {
        fg = "accent";
        bg = "cursor_bg";
        modifiers = [ "bold" ];
      };
      "ui.bufferline" = {
        fg = "gray";
        bg = "alt_bg";
      };
      "ui.bufferline.active" = {
        fg = "fg";
        bg = "alt_bg";
      };
      "ui.bufferline.background".bg = "alt_bg";
      "ui.popup".bg = "alt_bg";
      "ui.popup.info".bg = "alt_bg";
      "ui.help" = {
        fg = "fg";
        bg = "alt_bg";
      };
      "ui.window" = "medium_gray";
      "ui.menu" = {
        fg = "light_gray";
        bg = "accent";
      };
      "ui.menu.selected" = {
        fg = "blue";
        bg = "gray";
      };
      "ui.menu.scroll" = {
        fg = "light_gray";
        bg = "alt_bg";
      };
      "ui.highlight".bg = "accent";
      "ui.virtual.whitespace" = "gray";
      "ui.virtual.indent-guide" = "gray";
      "ui.virtual.ruler".bg = "alt_bg";
      "ui.virtual.inlay-hint" = "medium_gray";
      "ui.virtual.jump-label" = {
        fg = "orange";
        modifiers = [ "bold" ];
      };

      error = "error";
      warning = "warning";
      info = "info";
      hint = "hint";
      "diagnostic.error".underline = {
        color = "error";
        style = "curl";
      };
      "diagnostic.warning".underline = {
        color = "warning";
        style = "curl";
      };
      "diagnostic.info".underline = {
        color = "info";
        style = "curl";
      };
      "diagnostic.hint".underline = {
        color = "hint";
        style = "curl";
      };
      "diagnostic.unnecessary".modifiers = [ "dim" ];
      "diagnostic.deprecated".modifiers = [ "crossed_out" ];

      palette = {
        fg = "#E1E1E1";
        bg = "#151515";
        alt_bg = "#171717";
        accent = "#202020";
        gray = "#373737";
        medium_gray = "#727272";
        light_gray = "#AFAFAF";
        blue = "#BAD7FF";
        gray_blue = "#7E97AB";
        medium_gray_blue = "#A2B5C1";
        cyan = "#88AFA2";
        red = "#B46958";
        green = "#90A959";
        yellow = "#F4BF75";
        orange = "#FFA557";
        cursor_fg = "#151515";
        cursor_bg = "#D0D0D0";
        sign_add = "#586935";
        sign_change = "#51657B";
        sign_delete = "#984936";
        error = "#984936";
        warning = "#AB8550";
        info = "#AB8550";
        hint = "#576F82";
      };
    };
  };
}
