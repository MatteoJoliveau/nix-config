{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    gotop
    ffmpeg
    pulseaudio
    exa
    bat
    ripgrep
    fd
    jetbrains-mono
    p7zip
    nmap
    file
    patchelf
    inetutils
    wireguard-tools
    vips
    pciutils
    calc
    unstable.via
    unzip
    pv
    fzf
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
  };
}
