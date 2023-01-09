{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swappy
  ];

  xdg.configFile."swappy/config".source = ./config.ini;
}
