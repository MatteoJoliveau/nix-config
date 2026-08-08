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
    libreoffice-qt-fresh
    obs-studio
    scribus
    slack
    sniffnet
    spotify
    telegram-desktop
    vlc
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
