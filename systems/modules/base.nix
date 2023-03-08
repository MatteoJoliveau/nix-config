{ pkgs, ... }:

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

    # Flakes
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Configure GRUB 
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };

    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      enableCryptodisk = true;
    };
  };

  boot.plymouth.enable = true;

  # tmp on tmpfs
  boot.tmpOnTmpfs = true;

  # Add custom CA certs
  #   security.pki.certificates = [ (builtins.readFile ./codexlab-ca.crt) ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
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

  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    jetbrains-mono
  ];

  # Look, I don't like this either, but they are slow to fix those CVEs
  nixpkgs.config.permittedInsecurePackages = [ ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Firmware updates
  services.fwupd.enable = true;

  # Setup all the Steam machinery
  programs.steam.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "eurosign:e ctrl:nocaps";
    displayManager.gdm.enable = true;
  };

  location.provider = "geoclue2";

  # USB devices (Yubikey, Logitech receiver)
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.solaar pkgs.yubikey-personalization pkgs.libu2f-host ];

  # Thumbnail Service
  services.tumbler.enable = true;

  xdg.portal.enable = true;
  services.flatpak.enable = true;

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };
}
