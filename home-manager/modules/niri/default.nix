{
  config,
  unstable,
  pkgs,
  lib,
  noctalia,
  ...
}:

with lib;
let
  t = types;

  enabled = config.desktops.niri;
in
{
  imports = [
    noctalia.homeModules.default
  ];

  options = {
    programs.niri.config = mkOption {
      type = t.path;
    };
  };

  config = mkIf enabled {
    xdg.configFile = {
      "niri/config.kdl".source = config.programs.niri.config;
      "niri/common.kdl".source = ./common.kdl;
    };

    home.packages = with pkgs; [
      playerctl
      networkmanagerapplet # provides nm-connection-editor
    ];

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        colors = {
          background = "24273add";
          text = "cad3f5ff";
          prompt = "b8c0e0ff";
          placeholder = "8087a2ff";
          input = "cad3f5ff";
          match = "8aadf4ff";
          selection = "5b6078ff";
          selection-text = "cad3f5ff";
          selection-match = "8aadf4ff";
          counter = "8087a2ff";
          border = "8aadf4ff";
        };
      };
    };

    services.cliphist = {
      enable = true;
      allowImages = true;
    };

    services.polkit-gnome.enable = true;
  };
}
