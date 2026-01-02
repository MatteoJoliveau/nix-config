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

  programs.yazi = {
    enable = true;
  };

  programs.fish.functions.y.body = ''
    set -l tmp (mktemp -t "yazi-cwd.XXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
  '';

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
    PAGER = "${pkgs.bat}/bin/bat";
  };
}
