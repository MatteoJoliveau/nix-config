{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
