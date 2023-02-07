{ pkgs, hyprland, system, ... }:

let
  hyprpkgs = hyprland.packages."${system}";
in
{
  imports = [
    ./hyprpaper
    ./swappy
    ./swayidle
    ./swaync
    ./waybar
    ./avizo
    ./swaylock.nix
  ];

  home.packages = with pkgs; [
    wofi
    hyprpkgs.xdg-desktop-portal-hyprland
    playerctl
    brightnessctl
    wl-clipboard
    cliphist
    # Screenshots
    grim
    slurp
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
