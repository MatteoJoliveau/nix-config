{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    libsixel
  ];
  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
}
