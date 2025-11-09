{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {};
  };

  xdg.dataFile."niri/niri.desktop".source = let
    niri-session = pkgs.writeShellApplication {
      name = "niri-session";
      runtimeInputs = with pkgs; [
        nixgl.nixGLIntel
      ];
      text = ''
        GBM_BACKENDS_PATH="${pkgs.mesa}/lib/gbm" nixGLIntel ${pkgs.niri}/bin/niri-session
      '';
    };
  in
    pkgs.writeText "niri.desktop" ''
    [Desktop Entry]
    Name=niri
    Comment=niri
    Type=Application
    DesktopNames=niri
    Keywords=tiling
    Exec=${niri-session}/bin/niri-session
  '';

  systemd.user.services.niri = {
    Unit = {
      Description = "A scrollable-tiling Wayland compositor";
      BindsTo = "graphical-session.target";
      Before = ["graphical-session.target" "xdg-desktop-autostart.target"];
      Wants = ["graphical-session-pre.target" "xdg-desktop-autostart.target"];
      After = ["graphical-session-pre.target"];
    };

    Service = {
      Slice = "session.slice";
      Type = "notify";
      ExecStart = "${pkgs.niri}/bin/niri --session";
    };
  };

  systemd.user.targets.niri-shutdown = {
    Unit = {
      Description = "Shutdown running niri session";
      DefaultDependencies = "no";
      StopWhenUnneeded = "true";

      Conflicts = [ "graphical-session.target" "graphical-session-pre.targets"];
      After = [ "graphical-session.target" "graphical-session-pre.target"];
    };
  };
}
