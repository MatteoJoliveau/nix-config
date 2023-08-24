{ pkgs, system, ... }:

{
  imports = [
    ./hyprpaper
    ./swappy
    ./swaync
    ./waybar
    ./avizo
    ./swayidle.nix
    ./swaylock.nix
    ./kanshi.nix
  ];

  home.packages = with pkgs; [
    wofi
    unstable.xdg-desktop-portal-hyprland
    playerctl
    brightnessctl
    wl-clipboard
    cliphist
    swayidle
    # Screenshots
    grim
    slurp
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
