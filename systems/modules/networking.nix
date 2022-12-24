{ pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
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
