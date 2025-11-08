{ lib, ... }:

with lib;
{
  networking = {
    networkmanager.enable = mkDefault true;
    useDHCP = mkDefault true;
    enableIPv6 = true;
  };

  # Avahi/mDNS
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
