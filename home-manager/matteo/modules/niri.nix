config:
{
  unstable,
  pkgs,
  noctalia,
  ...
}:

{
  imports = [
    ./ghostty.nix
    noctalia.homeModules.default
  ];

  xdg.configFile."niri/config.kdl".source = config;

  home.packages = with pkgs; [
    playerctl
    xdg-desktop-portal-gnome
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
}
