{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        tree-sitter
        tree-sitter-langs
        treesit-grammars.with-all-grammars
      ];
  };

  home.packages = with pkgs; [
    emacs-lsp-booster
  ];

  xdg.configFile."emacs/init.el".source = ./init.el;
  xdg.configFile."emacs/early-init.el".source = ./early-init.el;
}
