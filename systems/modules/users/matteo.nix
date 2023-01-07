{ config, pkgs, lib, nixneovim, ... }:

{
  users.users.matteo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "libvirtd" ];
    shell = pkgs.fish;
  };

  home-manager.users.matteo = import ../../../home-manager/matteo/home.nix {
    inherit pkgs nixneovim;

    hostname = config.networking.hostName;
    stateVersion = config.system.stateVersion;
  };
}
