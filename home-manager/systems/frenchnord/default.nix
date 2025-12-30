{ pkgs, ... }:

{
  imports = [
    ../../modules
    ./noctalia.nix
  ];

  programs.niri.config = ./niri.kdl;

  home.packages = with pkgs; [ solaar ];
}
