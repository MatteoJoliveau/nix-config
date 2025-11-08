{ config, pkgs, lib, ... }:

with lib;
let
  enabled = config.roles.gaming;
in
mkIf enabled {
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  hardware.xone.enable = true;
}
