{
  config,
  pkgs,
  nixos-hardware,
  ...
}:

{
  imports = [
    ../../modules
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  roles = {
    development = true;
    gaming = true;
  };

  desktops = {
    niri = true;
    plasma = true;
  };

  networking.hostName = "frenchnord";

  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  fileSystems."/home/matteo/Games/Steam1" = {
    device = "/dev/disk/by-label/steam1";
    fsType = "ext4";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
