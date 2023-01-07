{ pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      gcc
      gnumake
      unzip
    ];
  };

  xdg.configFile."nvim/init.lua".source = ./config/init.lua;
  xdg.configFile."nvim/lua/settings.lua".source = ./config/settings.lua;
  xdg.configFile."nvim/after".source = ./config/after;
}
