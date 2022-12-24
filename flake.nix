{
  description = "Flake for my NixOS machines";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@attrs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        frenchpenguin = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = attrs;
          modules = [ ./systems/frenchpenguin ];
        };

        microwave = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = attrs;
          modules = [ ./systems/microwave ];
        };
      };

      # This I stole from https://gvolpe.com/blog/nix-flakes, thanks a lot!
      homeConfigurations = {
        matteo = import ./home-manager/matteo {
          inherit system nixpkgs home-manager;

          stateVersion = "22.11";
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
