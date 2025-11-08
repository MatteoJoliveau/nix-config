{ config, pkgs, lib, ... }:

with lib;
let
  enabled = config.desktops.niri;
in
mkIf enabled {
  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.swaylock = { };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
  ];
  xdg.portal.config.niri.default = ["gnome"];
}
