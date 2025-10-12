{ pkgs, lib, ... }:

{
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
}
