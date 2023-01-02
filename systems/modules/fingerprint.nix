{ ... }:

{
  security.polkit.enable = true;
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
}
