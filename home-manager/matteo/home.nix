{
  nixgl,
  nixosConfig,
  ...
}:

{
  imports = [
    (./hosts + "/${nixosConfig.networking.hostName}")
    ./modules/alacritty
    ./modules/fish
    ./modules/neovim
    ./modules/emacs
    ./modules/coreutils.nix
    ./modules/desktop.nix
    ./modules/development.nix
    ./modules/games.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/helix.nix
    ./modules/ssh.nix
  ];

  nixpkgs.overlays = [ ];

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  programs.home-manager.enable = true;
  manual.manpages.enable = false;
  home.stateVersion = nixosConfig.system.stateVersion;
}
