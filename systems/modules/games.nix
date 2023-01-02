{ pkgs, config, ... }:

{
  programs.steam.enable = true;
  programs.steam.package = pkgs.unstable.steam.override {
    extraLibraries = pkgs: with config.hardware.opengl;
      if pkgs.hostPlatform.is64bit
      then [ package ] ++ extraPackages
      else [ package32 ] ++ extraPackages32;
  };
}
