{ ... }:

{
  services = {
    acpid.enable = true;

    logind.extraConfig = ''
      HoldoffTimeoutSec=0
    '';

    power-profiles-daemon.enable = true;
  };

  powerManagement.powertop.enable = true;
}
