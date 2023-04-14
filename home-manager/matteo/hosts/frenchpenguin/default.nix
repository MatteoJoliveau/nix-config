{ pkgs, ... }:

let
setup-home-workspace = pkgs.writeScriptBin "setup-home-workspace" (builtins.readFile ./setup-home-workspace);
in
{
  imports = [
    ../../modules/bluetooth.nix
    ../../modules/wifi.nix
  ];

  home.packages = [
    setup-home-workspace
  ];

  xdg.configFile."kanshi/config".source = ./kanshi.conf;
}
