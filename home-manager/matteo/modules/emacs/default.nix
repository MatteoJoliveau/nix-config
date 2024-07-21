{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  xdg.configFile."emacs/init.el".source = ./init.el;
  xdg.configFile."emacs/early-init.el".source = ./early-init.el;
}
