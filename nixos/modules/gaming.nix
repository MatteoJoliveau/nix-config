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

  services.udev = {
    packages = with pkgs; [ oversteer ];

    # Rules for Logitech X56 HOTAS stick and throttle, otherwise Nuclear Option doesn't recognize them
    # https://steamcommunity.com/app/2168680/discussions/0/836124807123848513/
    extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="0738", ATTRS{idProduct}=="2221", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="0738", ATTRS{idProduct}=="a221", MODE="0666"
    '';
  };

  environment.systemPackages = with pkgs; [
    oversteer
  ];
}
