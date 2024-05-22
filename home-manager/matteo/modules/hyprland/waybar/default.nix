{ pkgs, system, ... }:

let
  waybar = pkgs.waybar;
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
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "battery" "pulseaudio" "custom/notification" ];
        "wlr/workspaces" = {
          "format" = "{name}";
          "on-click" = "activate";
          "sort-by-number" = true;
        };
        "hyprland/window" = {
          "separate-outputs" = true;
          "max-length" = 25;
        };
        "clock" = {
          "format" = "{:%a %d %b %t %R}";
          "calendar-weeks-pos" = "right";
          "today-calendar" = "<span color='#ff6699'><b><u>{}</u></b></span>";
          "format-calendar" = "<span color='#ecc6d9'><b>{}</b></span>";
          "format-calendar-weeks" = "<span color='#99ffdd'><b>W{:%U}</b></span>";
          "format-calendar-weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
          "on-scroll" = {
            "calendar" = 1;
          };
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
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
        "custom/notification" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
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
      Environment = "PATH=$PATH:/run/current-system/sw/bin:/etc/profiles/per-user/matteo/bin";
      ExecStart = "${waybar}/bin/waybar";
      ExecReload = "${pkgs.killall}/bin/killall -SIGUSR2 waybar";
      RestartSec = 5;
      Restart = "on-failure";
    };
  };
}
