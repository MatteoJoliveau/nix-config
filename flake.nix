{
  description = "Flake for my NixOS machines";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    suite-py.url = "suite-py";
    prima-nix.url = "prima-nix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , home-manager
    , suite-py
    , prima-nix
    , ...
    }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          prima-nix.overlays.default
          suite-py.overlays.default
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
            biscuit = super.callPackage nixpkgs/biscuit.nix { };
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
          modules = [
            prima-nix.nixosModules.default
            ./systems/frenchpenguin
            homeManagerWithArgs
          ];
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
