{ pkgs, ... }:

let
  lock-screen = pkgs.writeShellScriptBin "lock-screen" ''
    swaylock -f -i ~/Pictures/wallpaper.png --clock --indicator --effect-blur 7x5 --fade-in 0.5 ''${@}
  '';
in
{
  home.packages = with pkgs; [
    swaylock-effects
    lock-screen
  ];
  programs.swaylock.settings = { };
}
