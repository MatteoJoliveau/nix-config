{ ... }:

let
  port = 51820;
in
{
  networking.firewall.allowedUDPPorts = [ port ];

  networking.wg-quick.interfaces = {
    wg0 = {
      listenPort = port;
      address = [ "10.15.0.3/32" ];
      dns = [ "10.20.0.4" ];
      privateKeyFile = "/home/matteo/.wireguard/private.key";

      peers = [
        {
          publicKey = "L15bA+cgPUuV5jLcjEKPNq6SI7YMLHcr+/cyzTwFjVU=";
          allowedIPs = [
            "10.20.0.0/24"
            "10.20.30.0/24"
          ];
          endpoint = "access.matteojoliveau.com:13231";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
