{ pkgs, config, ... }:

{
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  hardware.xone.enable = true;
}
