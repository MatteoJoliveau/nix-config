{ config, pkgs, lib, ... }:

with lib;
let
  enabled = config.roles.writing;
in
mkIf enabled {
  home.packages = with pkgs; [
    unstable.novelwriter
    kdePackages.ghostwriter
  ];
}

