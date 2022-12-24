{ pkgs, ... }:

{
  imports = [
    ./greenclip.nix
  ];

  home.packages = with pkgs; [
    feh
    ark
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    gnome3.gnome-keyring
    gnome3.seahorse
    rofi
    rofimoji
    xss-lock
    ranger
    dconf
    playerctl
    brightnessctl
    picom
    xmobar
    pamixer
    flameshot
    xclip
    betterlockscreen
    rbw
    rofi-rbw
    dunst
    libnotify
    arandr
  ];

  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "change-background" = "~/.fehbg";
        "generate-lockscreen" = "betterlockscreen -u ~/Pictures/wallpaper.png";
      };
    };
  };

  home.file = {
    ".xprofile" = {
      source = ../xmonad/xmonad-session-rc;
      executable = true;
    };
    ".xmonad/xmonad.hs".source = ../xmonad/xmonad.hs;
    ".xmonad/xmobar.hs".source = ../xmonad/xmobar.hs;
    ".xmonad/bin/screenshot".source = ../xmonad/bin/screenshot;
    ".xmonad/bin/select-screenshot".source = ../xmonad/bin/select-screenshot;
    ".xmonad/bin/connect-known-bt".source = ../xmonad/bin/connect-known-bt;
    "Pictures/wallpaper.png".source = ../../../../images/wallpaper.png;
    "Pictures/propic.jpg".source = ../../../..//images/propic.jpg;
  };

  xdg.configFile = {
    "betterlockscreenrc".source = ./betterlockscreen.cfg;
    "dunst/dunstrc".source = ./dunstrc;
    "picom/picom.conf".source = ./picom.conf;
    "rofi/config.rasi".source = ./rofi/config.rasi;
    "rofi/onedark.rasi".source = ./rofi/onedark.rasi;
    "rbw/config.json".text = ''
      {
        "email": "matteojoliveau@gmail.com",
        "pinentry": "${pkgs.pinentry-gtk2}/bin/pinentry-gtk-2"
      }
    '';
    "flameshot/flameshot.ini".source = ./flameshot.ini;
  };
}
