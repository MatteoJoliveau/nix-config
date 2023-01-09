{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaylock-effects
  ];
  programs.swaylock.settings = {
    
  };
}
