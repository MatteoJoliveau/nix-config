{ pkgs, system, hyprland, ... }:

let
  hyprpkgs = hyprland.packages."${system}";
  waybar = hyprpkgs.waybar-hyprland;

  # This fixes the "hyprctl: command not found" issues I was having
  start-waybar = pkgs.writeShellScriptBin "start-waybar" ''
    export PATH=$PATH:${hyprpkgs.default}/bin
    ${waybar}/bin/waybar
  '';
in
{
  programs.waybar = {
    enable = true;
    package = waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 10;
        modules-left = [ "wlr/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "battery" "pulseaudio" ];
        "wlr/workspaces" = {
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
        };
        "hyprland/window" = {
          separate-outputs = true;
        };
        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          "format-icons" = [ "" "" "" "" "" ];
        };
        "network" = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" = "pavucontrol";
        };
      };
    };
    style = ./styles.css;
  };

  systemd.user.services.waybar = {
    Unit = {
      Description = "Wayland bar for Wlroots based compositors";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${start-waybar}/bin/start-waybar";
      ExecReload = "${pkgs.killall}/bin/killall -SIGUSR2 waybar";
      RestartSec = 5;
      Restart = "on-failure";
    };
  };
}
