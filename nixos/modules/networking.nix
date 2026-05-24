{ lib, ... }:

with lib;
{
  networking = {
    networkmanager.enable = mkDefault true;
    useDHCP = mkDefault true;
    enableIPv6 = true;

    firewall = {
      allowedTCPPorts = [
        4173
        5173
      ];

      extraCommands = "
        iptables -I nixos-fw 1 -i br+ -j ACCEPT
      ";

      extraStopCommands = "
        iptables -D nixos-fw -i br+ -j ACCEPT
      ";
    };

    hosts = {
      "127.0.0.1" = ["host.docker.internal"];
    };
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
