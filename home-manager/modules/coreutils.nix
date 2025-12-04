{ pkgs, ... }:

let
  aspell' = pkgs.aspellWithDicts (dicts: [
    dicts.en
    dicts.it
  ]);
in
{
  home.packages = with pkgs; [
    aspell'
    bat
    bottom
    calc
    cpufetch
    dust
    eza
    fastfetch
    fd
    ffmpeg
    file
    fzf
    git
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
    unzip
    usbutils
    via
    vips
    wget
    wireguard-tools
    wl-clipboard-rs
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
    PAGER = "${pkgs.bat}/bin/bat";
  };
}
