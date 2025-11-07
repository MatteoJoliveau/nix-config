{ config, pkgs, ... }:

{
  nix = {
    # Automatically optimise the Nix store
    settings.auto-optimise-store = true;
    # Automatically cleanup derivation older than a month each week
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;

  # tmp on tmpfs
  boot.tmp.useTmpfs = true;

  # Add custom CA certs
  #   security.pki.certificates = [ (builtins.readFile ./codexlab-ca.crt) ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  time.timeZone = "Europe/Rome";
  # time.timeZone = "Atlantic/Canary";

  # NTP
  services.chrony.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    bind
    unstable.wget
    vim
    neofetch
    cpufetch
    git
    xorg.xmodmap
    plymouth
    usbutils
    glxinfo # glxinfo, eglinfo
    vulkan-tools # vulkan-info
    wayland-utils # wayland-info
  ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];

  # Firmware updates
  services.fwupd.enable = true;

  location.provider = "geoclue2";

  # USB devices (Yubikey, Logitech receiver)
  services.pcscd.enable = true;
  services.udev.packages = [
    pkgs.solaar
    pkgs.yubikey-personalization
    pkgs.libu2f-host
  ];

  # Thumbnail Service
  services.tumbler.enable = true;

  xdg.portal.enable = true;
  services.flatpak.enable = true;

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };
}
