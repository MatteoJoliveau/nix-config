{ config, pkgs, ... }:

{
  imports = [
    ./modules/alacritty
    ./modules/fish
    ./modules/emacs
    ./modules/development.nix
    ./modules/git.nix
    ./modules/gpg.nix
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  home.packages = with pkgs; [
    gotop
    eza
    bat
    ripgrep
    fd
    jetbrains-mono
    fzf
    zoxide
    firefox
    ungoogled-chromium
    nextcloud-client
    obs-studio
    slack
    spotify
    tdesktop
    vlc
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
