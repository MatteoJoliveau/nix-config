{ config, pkgs, system, ... }:

{
  users.users.matteo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "libvirtd" ];
    shell = pkgs.fish;
  };

  home-manager.users.matteo.imports = [ ../../../home-manager/matteo/home.nix ];
}
