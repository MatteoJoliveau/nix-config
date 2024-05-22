{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "eurosign:e ctrl:nocaps";
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
  ];

  programs.dconf.enable = true;
}
