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
}
