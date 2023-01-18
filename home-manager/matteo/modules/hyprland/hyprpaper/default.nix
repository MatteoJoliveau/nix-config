{ hyprpaper, system, ... }:

let
  hyprpaper-pkg = hyprpaper.packages."${system}".default;
in
{
  home.packages = [
    hyprpaper-pkg
  ];

  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file."Pictures/wallpaper.png".source = ../../../../../images/wallpaper.png;


  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprpaper is a blazing fast wayland wallpaper utility with IPC controls.";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${hyprpaper-pkg}/bin/hyprpaper";
      RestartSec = 5;
      Restart = "on-failure";
    };
  };
}
