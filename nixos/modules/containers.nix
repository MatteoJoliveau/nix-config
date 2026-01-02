{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  enabled = config.roles.development;
in
mkIf enabled {
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
