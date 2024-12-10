{ config, pkgs, ... }:

{
  imports = [
    ./modules/coreutils.nix
    ./modules/development.nix
    ./modules/emacs
    ./modules/fish
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/helix.nix
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gitleaks
    nextcloud-client
    obs-studio
    pandoc
    steam-run
    suite_py
    tdesktop
    vesktop
    vlc
  ];

  xdg.enable = true;
  xdg.systemDirs.data = [
    "/usr/share/glib-2.0/schemas"
    "/usr/share/ubuntu"
    "/usr/share/gnome"
    "/usr/local/share"
    "/usr/share"
    "/var/lib/flatpak/exports/share"
    "~/.local/share/flatpak/exports/share"
  ];

  home.username = "matteojoliveau";
  home.homeDirectory = "/home/matteojoliveau";
  home.stateVersion = "23.11";
}
