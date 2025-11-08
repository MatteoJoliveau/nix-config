{ pkgs, ... }:

{
  services.fwupd.enable = true;

  services.pcscd.enable = true;
  services.udev.packages = with pkgs; [
    solaar
    yubikey-personalization
    libu2f-host
  ];

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };
}
