{ ...}:

{
    services = {
    acpid.enable = true;

    logind.extraConfig = ''
      HoldoffTimeoutSec=0
    '';
  };
  
powerManagement.powertop.enable = true;
  # Please NVIDIA don't drain my battery
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = true;
}