{ config, pkgs, lib, ... }:

with lib;
let
  enabled = any id (attrValues config.desktops);
in
mkIf enabled {
  home.packages = with pkgs; [
    bitwarden
    desktop-file-utils
    easyeffects
    deluge
    krita
    languagetool
    libreoffice-fresh
    libsecret
    nextcloud-client
    obs-studio
    obsidian
    scribus
    slack
    sniffnet
    spotify
    tdesktop
    vlc
  ];

  programs.firefox.enable = true;
}
