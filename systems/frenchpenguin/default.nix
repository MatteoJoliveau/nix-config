{ config, pkgs, lib, home-manager, nixos-hardware, ... }:

{
  imports =
    [
      ../modules/users/matteo.nix
      ../modules/docker.nix
      ../modules/networking.nix
      ../modules/gnome.nix
      ./hardware-configuration.nix
      nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
      home-manager.nixosModule
    ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Networking
  networking.hostName = "frenchpenguin"; # Define your hostname
  # networking.interfaces.wlp0s20f3.useDHCP = true;
  # temporary
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  # Generate an immutable /etc/resolv.conf from the nameserver settings
  # above (otherwise DHCP overwrites it):
  environment.etc."resolv.conf" = with lib; with pkgs; {
    source = writeText "resolv.conf" ''
      ${concatStringsSep "\n" (map (ns: "nameserver ${ns}") config.networking.nameservers)}
      options edns0
    '';
  };

  #   # Additional packages
  #   environment.systemPackages = with pkgs; [
  #     firehol
  #   ];

  hardware.opengl = {
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;
  powerManagement.powertop.enable = true;

  services = {
    acpid.enable = true;

    logind.extraConfig = ''
      HoldoffTimeoutSec=0
    '';
  };

  # Enable Thunderbolt
  services.hardware.bolt.enable = true;

  # Please NVIDIA don't drain my battery
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = true;

  services.autorandr.enable = true;

  security.polkit.enable = true;
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;

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


  # # Configure GRUB 
  # boot.loader = {
  #   efi = {
  #     canTouchEfiVariables = false;
  #   };

  #   grub = {
  #     enable = true;
  #     version = 2;
  #     device = "nodev";
  #     efiSupport = true;
  #     efiInstallAsRemovable = true;
  #     useOSProber = true;
  #     enableCryptodisk = true;
  #   };
  # };

  # boot.plymouth.enable = true;

  # tmp on tmpfs
  boot.tmpOnTmpfs = true;

  # Add custom CA certs
  security.pki.certificates = [ /* (builtins.readFile ./my-ca.crt) */ ];

  # Add Kernel modules
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  time.timeZone = "Europe/Rome";

  # OpenDoas
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; keepEnv = true; persist = true; }
    ];
  };

  # NTP
  services.chrony.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    bind
    wget
    vim
    neofetch
    cpufetch
    git
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    plymouth
    usbutils
  ];

  nixpkgs.config.allowUnfree = true;

  # Look, I don't like this either, but they are slow to fix those CVEs
  nixpkgs.config.permittedInsecurePackages = [
    "libsixel-1.8.6"
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;

    # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
    extraConfig = "
      load-module module-switch-on-connect
    ";
  };

  # Firmware updates
  services.fwupd.enable = true;

  # For steam
  hardware.opengl.driSupport32Bit = true;

  services.redshift = {
    enable = true;
    temperature.day = 6500;
  };

  location.provider = "geoclue2";

  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;


  # Enable Virt Manager
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };

  # USB devices (Yubikey, Logitech receiver)
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.solaar pkgs.yubikey-personalization pkgs.libu2f-host ];

  # Pretty much means that there's logitech hardware.
  # This ensures they always can be used during initrd.
  boot.initrd.kernelModules = [
    "hid_logitech_dj"
    "hid_logitech_hidpp"
  ];

  # Accounts Service
  services.accounts-daemon.enable = true;

  # Thumbnail Service
  services.tumbler.enable = true;


  xdg.portal.enable = true;
  services.flatpak.enable = true;

  services.gvfs.enable = true;

  system = {
    stateVersion = "22.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };

}
