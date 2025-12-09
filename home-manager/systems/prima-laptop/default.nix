{ config, nixgl, pkgs, lib, ... }:

with lib;
{
  imports = [
    ../../modules
  ];

  roles.development = true;

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  nixpkgs.config.allowUnfree = true;

  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
    vulkan.enable = true;
  };

  home.packages = with pkgs; [
    gitleaks
    # (config.lib.nixGL.wrap nextcloud-client)
  ];

  xdg.enable = true;
#  xdg.systemDirs.data = [
#    "/usr/share/glib-2.0/schemas"
#    "/usr/share/ubuntu"
#    "/usr/share/gnome"
#    "/usr/local/share"
#    "/usr/share"
#    "/var/lib/flatpak/exports/share"
#    "~/.local/share/flatpak/exports/share"
#  ];

  home.username = "matteojoliveau";
  home.homeDirectory = "/home/matteojoliveau";
  home.stateVersion = "23.11";
}
