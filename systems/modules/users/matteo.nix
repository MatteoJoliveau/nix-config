{ config, pkgs, lib, ... }:

{
  users.users.matteo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "libvirtd" ];
    shell = pkgs.fish;
    password = "";
  };

  home-manager.users.matteo = { pkgs, ... }: {
    programs.fish.enable = true;
    home.stateVersion = "22.11";
  };
}
