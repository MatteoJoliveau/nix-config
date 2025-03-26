{ pkgs, ... }:

let
  aspell' = pkgs.aspellWithDicts (dicts: [dicts.en dicts.it]);
in
{
  home.packages = with pkgs; [
    aspell'
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
    kondo
    libtool
    nmap
    openssh
    p7zip
    patchelf
    pciutils
    pulseaudio
    pv
    rfc
    rip2
    ripgrep
    television
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

  programs.nh = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
  };
}
