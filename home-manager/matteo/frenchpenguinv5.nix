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
    bat
    eza
    fd
    firefox
    fzf
    gotop
    jetbrains-mono
    nextcloud-client
    obs-studio
    ripgrep
    slack
    spotify
    tdesktop
    ungoogled-chromium
    vesktop
    vlc
    zoxide
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
