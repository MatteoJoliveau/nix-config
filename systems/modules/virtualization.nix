{ pkgs, ... }:

{
  # Enable Virt Manager
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
