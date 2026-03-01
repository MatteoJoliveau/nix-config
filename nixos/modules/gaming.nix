{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  enabled = config.roles.gaming;
in
mkIf enabled {
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  hardware.xone.enable = true;
  hardware.new-lg4ff.enable = true;
  hardware.usb-modeswitch.enable = true;

  services.udev.packages = with pkgs; [ oversteer ];

  environment.systemPackages = with pkgs; [
    oversteer
  ];
}
