{ config, pkgs, lib, ... }:

with lib;
let
  enabled = any id (attrValues config.desktops);
in
mkIf enabled {
  services.displayManager.sddm.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
    options = "eurosign:e ctrl:nocaps";
  };

  programs.partition-manager.enable = true;

  services.printing.enable = true;
  programs.dconf.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.acpid.enable = true;

  services.tuned = {
    enable = true;
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
