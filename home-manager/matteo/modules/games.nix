{ pkgs, ... }:

{
  home.packages = with pkgs; [
    heroic
    dungeondraft
    wonderdraft
  ];
}
