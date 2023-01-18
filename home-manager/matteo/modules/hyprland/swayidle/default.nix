{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swayidle
  ];
  xdg.configFile."swayidle/config".source = ./config.ini;

  systemd.user.services.swayidle = {
    Unit = {
      Description = "SwayIdle";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swayidle}/bin/swayidle -w";
      RestartSec = 5;
      Restart = "on-failure";
    };
  };

}
