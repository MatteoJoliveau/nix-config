{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    calc
    du-dust
    eza
    fd
    ffmpeg
    file
    fzf
    git
    gotop
    htop
    inetutils
    jetbrains-mono
    libtool
    nmap
    openssh
    p7zip
    patchelf
    pciutils
    pulseaudio
    pv
    rip2
    ripgrep
    via
    unzip
    vips
    wireguard-tools
    zoxide
  ];

  fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
  };
}
