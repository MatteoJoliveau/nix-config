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
    godotPackages_4_5.godot-mono
    godotPackages_4_5.export-templates-mono-bin
    unstable.shadps4
    steam-run
    prismlauncher
  ];
}
