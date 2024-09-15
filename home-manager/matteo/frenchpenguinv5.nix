{ suite-py, ... }:
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
    steam-run
    nextcloud-client
    obs-studio
    pandoc
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
