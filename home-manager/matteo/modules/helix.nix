{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;

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

      keys.normal = {
        space.space = "file_picker";
        G = "goto_last_line";
        V = [ "select_mode" "extend_to_line_bounds" ];
      };
    };
  };
}
