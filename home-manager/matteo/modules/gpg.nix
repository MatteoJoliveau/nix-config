{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
