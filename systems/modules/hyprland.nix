{ pkgs, ... }:

{
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "eurosign:e ctrl:nocaps";

    displayManager.gdm.enable = true;
  };

  programs.hyprland.enable = true;
  programs.hyprland.package = pkgs.unstable.hyprland;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
