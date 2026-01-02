{ lib, ... }:

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
    ./ssh.nix
    ./writing.nix
  ];

  options = {
    roles = {
      development = mkEnableOption "development";
      gaming = mkEnableOption "gaming";
      writing = mkEnableOption "writing";
    };

    desktops = {
      plasma = mkEnableOption "KDE Plasma";
      niri = mkEnableOption "niri";
    };
  };

  config = {
    programs.home-manager.enable = true;
    manual.manpages.enable = false;
    programs.nix-index.enable = true;

    home.file.".face".source = ../../images/propic.jpg;

    home.keyboard = {
      layout = "us";
      variant = "altgr-intl";
      options = "eurosign:e ctrl:nocaps";
    };
  };
}
