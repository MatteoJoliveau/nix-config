{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kanshi
  ];

  systemd.user.services.kanshi = {
    Unit = {
      Description = "kanshi allows you to define output profiles that are automatically enabled and disabled on hotplug";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Environment="PATH=$PATH:/run/current-system/sw/bin:/etc/profiles/per-user/matteo/bin";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      RestartSec = 5;
      Restart = "on-failure";
    };
  };
}
