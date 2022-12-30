{ pkgs, ... }:

{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.tiling-assistant
    gnomeExtensions.pano
    gnomeExtensions.mpris-indicator-button
    gnomeExtensions.dash-to-dock

    gnome.gnome-tweaks
  ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
