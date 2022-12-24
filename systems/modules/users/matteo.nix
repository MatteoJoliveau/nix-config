{ config, pkgs, lib, ... }:

{
  users.users.matteo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "libvirtd" ];
    shell = pkgs.fish;
    password = "";
  };

  home-manager.users.matteo = import ../../../home-manager/matteo/home.nix {
    inherit pkgs;

    hostname = config.networking.hostName;
    stateVersion = config.system.stateVersion;
  };
}
