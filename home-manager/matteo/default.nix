{ system, nixpkgs, home-manager, stateVersion, ... }:

let
  username = "matteo";
  homeDirectory = "/home/${username}";
  configDir = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
    config.xdg.configHome = configDir;

    packageOverrides = pkgs: with pkgs; rec {
      unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {
        config = {
          allowUnfree = true;
        };
      };

      krew = callPackage ../../nixpkgs/krew.nix { };
      calc = callPackage ../../nixpkgs/calc { };
      httpie-desktop = pkgs.callPackage ../../nixpkgs/httpie-desktop.nix { };
    };
  };
  {
  main = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system username homeDirectory stateVersion;

    configuration = import ./home.nix
      {
        inherit pkgs;
        inherit (pkgs) config lib stdenv;
      }
      }
      }
