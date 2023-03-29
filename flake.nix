{
  description = "Flake for my NixOS machines";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    pano-overlay.url = "github:michojel/nixpkgs/gnome-shell-extension-pano";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    pypi-deps-db.url = "github:DavHau/pypi-deps-db/5aee18e82980d5d62679a8c4a33ddbd57aab8522";
    # suite-py.url = "./nixpkgs/suite-py/";
      };

    outputs =
      { self
      , nixpkgs
      , nixpkgs-unstable
      , flake-utils
      , home-manager
      , pano-overlay
      , hyprland
      , hyprpaper
      # , suite-py
      , ...
      }@attrs:
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;

          config.allowUnfree = true;

          overlays = [
            (import ./systems/overlays/gnome-pano { inherit pano-overlay; })
            (self: super: {
              unstable = import nixpkgs-unstable {
                inherit system;

                config = {
                  allowUnfree = true;
                };
              };

              krew = super.callPackage nixpkgs/krew.nix { };
              calc = super.callPackage nixpkgs/calc { };
              httpie-desktop = super.callPackage nixpkgs/httpie-desktop.nix { };
              # suite-py = suite-py.packages.${system}.default;
              # cargo-dist = super.callPackage nixpkgs/cargo-dist.nix { inherit naersk; };
            })
          ];
        };
        homeManagerWithArgs = { home-manager.extraSpecialArgs = attrs // { inherit system; }; };
      in
      {
        nixosConfigurations = {
          frenchpenguin = nixpkgs.lib.nixosSystem {
            inherit system pkgs;

            specialArgs = attrs;
            modules = [ ./systems/frenchpenguin homeManagerWithArgs ];
          };

          microwave = nixpkgs.lib.nixosSystem {
            inherit system pkgs;

            specialArgs = attrs;
            modules = [ ./systems/microwave homeManagerWithArgs ];
          };
        };
      } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell
          {
            buildInputs = with pkgs; [
            ];
          };
      }
      );
  }
