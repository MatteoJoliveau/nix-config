{ lib, pkgs, ... }:

with lib;
{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./containers.nix
    ./firmware.nix
    ./gaming.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./desktop
    ./users.nix
  ];

  options = {
    roles = {
      development = mkEnableOption "development";
      gaming = mkEnableOption "gaming";
    };

    desktops = {
      plasma = mkEnableOption "KDE Plasma";
      niri = mkEnableOption "niri";
    };
  };

  config = {
    services.chrony.enable = true;

    services.tumbler.enable = true;

    xdg.portal.enable = true;

    services.flatpak.enable = true;
  };
}
