{ pkgs, hyprland, ... }:

{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  imports = [ hyprland.nixosModules.default ];

  programs.hyprland.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
