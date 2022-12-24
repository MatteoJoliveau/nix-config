{ pkgs, ... }:

{
  # Configure LightDM Enso theme
  services.xserver.displayManager.lightdm.greeters.enso = {
    enable = true;
    blur = true;
  };

  # Enable xmonad
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  services.redshift = {
    enable = true;
    temperature.day = 6500;
  };

  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  services.accounts-daemon.enable = true;
  services.gvfs.enable = true;
}
