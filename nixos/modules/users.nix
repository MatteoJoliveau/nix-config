{
  config,
  pkgs,
  lib,
  ...
}:

let
  hostname = config.networking.hostName;
in
{
  imports = [
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];

  nix.settings.trusted-users = [ "matteo" ];

  users.mutableUsers = true;

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

  home-manager.users.matteo.imports = [
    (../../home-manager/systems + "/${hostname}")
    (with config; {
      inherit roles desktops;

      programs.home-manager.enable = true;
      manual.manpages.enable = false;
      home.stateVersion = config.system.stateVersion;
    })
  ];

  # OpenDoas
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };
}
