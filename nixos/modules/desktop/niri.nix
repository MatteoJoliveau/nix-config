{
  config,
  pkgs,
  lib,
  ...
}:

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
    (xwayland-satellite.overrideAttrs (
      final: prev: {
        version = "0.8.0";
        src = fetchFromGitHub {
          owner = "Supreeeme";
          repo = "xwayland-satellite";
          rev = "9a71e77b1e06dbad4a472265e59b52ac83cbe00c";
          sha256 = "sha256-Qz1WvGdawnoz4dG3JtCtlParmdQHM5xu6osnXeVOqYI=";
        };

        cargoDeps = prev.cargoDeps.overrideAttrs (
          _: prev': {
            vendorStaging = prev'.vendorStaging.overrideAttrs {
              inherit (final) src;
              outputHash = "sha256-HGrMjNIsUqh8AFtSABk615x4B9ygrVEn26V0G1kX/nA=";
            };
          }
        );
      }
    ))
  ];

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    gnome-keyring
  ];

  xdg.portal.config.niri = {
    default = [
      "gnome"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Access" = [ "gtk" ];
    "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
    "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  };
}
