{ suite-py, ... }:
{ config, pkgs, ... }:

{
  imports = [
    ./modules/coreutils.nix
    ./modules/fish
    ./modules/emacs
    ./modules/development.nix
    ./modules/git.nix
    ./modules/gpg.nix
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    steam-run
    nextcloud-client
    obs-studio
    pandoc
    slack
    spotify
    tdesktop
    vesktop
    vlc
    suite-py
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
}
