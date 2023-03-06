{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile."swaync/config.json".source = ./config.json;

  systemd.user.services.swaync = {
    Unit = {
      Description = "Sway Notifications Center";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      ExecReload = "${pkgs.swaynotificationcenter}/swaync-client --reload-config ; ${pkgs.swaynotificationcenter}/swaync-client --reload-css";
      RestartSec = 5;
      Restart = "always";
    };
  };
}
