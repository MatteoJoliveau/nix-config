{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
