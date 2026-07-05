{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  enabled = any id (attrValues config.desktops);
in
mkIf enabled {
  home.packages = with pkgs; [
    deluge
    desktop-file-utils
    discord
    easyeffects
    google-chrome
    languagetool
    libsecret
    nextcloud-client
    obs-studio
    scribus
    slack
    sniffnet
    spotify
    telegram-desktop
    vlc
  ];

  programs.firefox.enable = true;
}
