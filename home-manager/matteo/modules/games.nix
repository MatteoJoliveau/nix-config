{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.heroic
    godotPackages_4_5.godot-mono
    godotPackages_4_5.export-templates-mono-bin
    steam-run
  ];
}
