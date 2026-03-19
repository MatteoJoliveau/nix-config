{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  enabled = config.roles.gamedev;
in
mkIf enabled {
  home.packages = with pkgs.unstable; [
    blender
    tiled
  ];
}
