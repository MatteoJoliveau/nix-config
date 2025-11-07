{ ... }:

{
  imports = [
    ../../modules/desktop.nix
    ../../modules/games.nix
    (import ../../modules/niri.nix ./niri.kdl)
    ./noctalia.nix
  ];
}
