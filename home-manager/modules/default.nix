{ config, lib, ... }:

with lib;
{
    imports = [
      ./bluetooth.nix
      ./coreutils.nix
      ./desktop.nix
      ./devtools.nix
      ./fish
      ./gaming.nix
      ./ghostty.nix
      ./git.nix
      ./gpg.nix
      ./helix.nix
      ./niri
    ];

  options = {
    roles = {
      development = mkEnableOption "development";
      gaming = mkEnableOption "gaming";
    };

    desktops = {
      plasma = mkEnableOption "KDE Plasma";
      niri = mkEnableOption "niri";
    };
  };

  config = {
    programs.ssh.enable = true;

    programs.home-manager.enable = true;
    manual.manpages.enable = false;
    programs.nix-index.enable = true;
    home.file.".face".source = ../../images/propic.jpg;
  };
}
