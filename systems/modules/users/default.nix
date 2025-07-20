{ home-manager, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];

  users.mutableUsers = true;

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
