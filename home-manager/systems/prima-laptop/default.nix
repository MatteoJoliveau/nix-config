{ ... }:

{
  imports = [
    ../../modules
    ./noctalia.nix
  ];

  programs.niri.config = ./niri.kdl;
}
