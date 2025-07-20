{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    package = pkgs.helix-unstable;

    settings = {
      theme = "onedark";

      editor = {
        auto-save = true;
        bufferline = "multiple";
        color-modes = true;

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        cursor-shape = {
          normal = "hidden";
          insert = "bar";
          select = "block";
        };

        soft-wrap.enable = true;
      };

      keys =
        let
          common = {
            tab = "indent";
            S-tab = "unindent";
            y = "yank_to_clipboard";
            p = "paste_clipboard_after";
            r = "replace_selections_with_clipboard";
            R = "replace";
          };
        in
        {
          normal = common // {
            space.p.f = "file_picker";
            space.f = ":format";
            q = ":write-buffer-close";
            G = "goto_last_line";
            r = "replace_selections_with_clipboard";
            R = "replace";
            x = [
              "select_mode"
              "extend_line_below"
            ];
            X = [
              "select_mode"
              "extend_line_above"
            ];
            C-space = "completion";
          };

          select = common // { };
        };
    };
  };
}
