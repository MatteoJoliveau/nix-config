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
  home.packages = with pkgs; [
    unstable.heroic
    unstable.shadps4
    steam-run
    prismlauncher
    openmw
  ];
}
