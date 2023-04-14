{ pkgs, ... }:

{
  imports = [
    ../../modules/bluetooth.nix
    ../../modules/wifi.nix
  ];

  xdg.configFile."kanshi/config".source = ./kanshi.conf;
}
