{ pkgs, ... }:

let
  l = builtins // pkgs.lib;
in
{
  home.packages = with pkgs; [
    libsixel
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      keyboard.bindings = [
        {
          action = "Paste";
          key = "V";
          mods = "Alt";
        }
        {
          action = "Copy";
          key = "C";
          mods = "Alt";
        }
      ];

      cursor.unfocused_hollow = true;

      colors = {
        primary = {
          background = "0x282828";
          bright_foreground = "0xfbf1c7";
          dim_foreground = "0xa89984";
          foreground = "0xfbf1c7";
        };

        bright = {
          black = "0x1d2021";
          blue = "0x83a598";
          cyan = "0x8ec07c";
          green = "0xb8bb26";
          magenta = "0xd3869b";
          red = "0xfb4934";
          white = "0xffffff";
          yellow = "0xfabd2f";
        };

        normal = {
          black = "0x000000";
          blue = "0x458588";
          cyan = "0x689d6a";
          green = "0x90971a";
          magenta = "0xb16286";
          red = "0xcc241d";
          white = "0xeaeaea";
          yellow = "0xd79921";
        };
      };

      font =
        let
          family = "JetBrains Mono";
          mkFont = style: { inherit family style; };
        in
        {
          normal = mkFont "Regular";
          bold = mkFont "Bold";
          bold_italic = mkFont "Bold Italic";
          italic = mkFont "Italic";
        };

      window = {
        decorations = "full";
        dynamic_title = true;
        opacity = 0.95;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };
    };
  };
}
