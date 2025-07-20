{ pkgs, ... }:

let
  setup-home-workspace = pkgs.writeScriptBin "setup-home-workspace" (
    builtins.readFile ./setup-home-workspace
  );
in
{
  imports = [
    ../../modules/bluetooth.nix
    ../../modules/wifi.nix
    ../../modules/hyprland
  ];

  home.packages = [
    setup-home-workspace
  ];

  xdg.configFile."kanshi/config".source = ./kanshi.conf;
  home.file.".cargo/config.toml".source = ./cargo.toml;
}
