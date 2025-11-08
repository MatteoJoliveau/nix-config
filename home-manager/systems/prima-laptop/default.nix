{ nixgl, pkgs, ... }:

{
  imports = [
    ../../modules
    ./noctalia.nix
  ];

  programs.niri.config = ./niri.kdl;

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  nixpkgs.config.allowUnfree = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];
  nixGL.vulkan.enable = true;

  home.packages = with pkgs; [
    gitleaks
    (config.lib.nixGL.wrap nextcloud-client)
    suite_py
  ];

  xdg.enable = true;
  xdg.systemDirs.data = [
    "/usr/share/glib-2.0/schemas"
    "/usr/share/ubuntu"
    "/usr/share/gnome"
    "/usr/local/share"
    "/usr/share"
    "/var/lib/flatpak/exports/share"
    "~/.local/share/flatpak/exports/share"
  ];

  home.username = "matteojoliveau";
  home.homeDirectory = "/home/matteojoliveau";
  home.stateVersion = "23.11";
}
