{ pkgs, hostname, stateVersion, ... }:
{
  imports = [
    (./hosts + "/${hostname}")
    ./modules/alacritty
    ./modules/coreutils.nix
    ./modules/desktop.nix
    ./modules/development.nix
    ./modules/fish
    ./modules/git.nix
    ./modules/gpg.nix
  ];

  nixpkgs.overlays = [
    # Re-enable if upstream is slacking off
    # (import ./overlays/discord.nix)
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = false;
  home.stateVersion = stateVersion;
}
