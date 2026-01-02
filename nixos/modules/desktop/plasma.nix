{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  enabled = config.desktops.plasma;
in
mkIf enabled {
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    konsole
  ];
}
