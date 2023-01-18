{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    avizo
    pamixer
  ];
  xdg.configFile."avizo/config.ini".source = ./config.ini;

  systemd.user.services.avizo = {
    Unit = {
      Description = "Avizo";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.avizo}/bin/avizo-service";
      RestartSec = 5;
      Restart = "always";
    };
  };
}
