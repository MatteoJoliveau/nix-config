{ config, pkgs, nixosConfig, ... }:

{
  imports = [
    (./hosts + "/${nixosConfig.networking.hostName}")
    ./modules/alacritty
    ./modules/fish
    ./modules/hyprland
    ./modules/neovim
    ./modules/emacs
    ./modules/coreutils.nix
    ./modules/desktop.nix
    ./modules/development.nix
    ./modules/games.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/helix.nix
    ./modules/ssh.nix
  ];

  nixpkgs.overlays = [
    # Re-enable if upstream is slacking off
    # (import ./overlays/discord.nix)
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = false;
  home.stateVersion = nixosConfig.system.stateVersion;
}
