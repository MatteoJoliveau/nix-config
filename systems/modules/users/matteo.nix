{
  config,
  pkgs,
  system,
  ...
}:

{
  users.users.matteo = {
    isNormalUser = true;
    description = "Matteo";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "libvirtd"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  home-manager.users.matteo.imports = [ ../../../home-manager/matteo/home.nix ];
}
