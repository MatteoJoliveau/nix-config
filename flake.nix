{
  description = "Flake for my NixOS machines";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager/release-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    suite-py.url = "suite-py";

    megasploot.url = "github:matteojoliveau/megasploot.nix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , home-manager
    , home-manager-unstable
    , suite-py
    , megasploot
    , ...
    }@attrs:
    let
      system = "x86_64-linux";
      pks = import nixpkgs { inherit system; };
      mkPkgs = channel: import channel {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          suite-py.overlays.default
          megasploot.overlays.default
          (self: super: {
            unstable = import nixpkgs-unstable {
              inherit system;

              config = {
                allowUnfree = true;
              };
            };

            krew = super.callPackage nixpkgs/krew.nix { };
            calc = super.callPackage nixpkgs/calc { };
            biscuit = super.callPackage nixpkgs/biscuit.nix { };
          })
          # https://github.com/nix-community/home-manager/issues/322#issuecomment-1178614454
          (self: super: {
            openssh = super.openssh.overrideAttrs (old: {
              patches = (old.patches or [ ]) ++ [ ./patches/openssh.patch ];
              doCheck = false;
            });
          })
        ];
      };
      pkgs = mkPkgs nixpkgs;
      homeManagerWithArgs = { home-manager.extraSpecialArgs = attrs // { inherit system; }; };
      homeManagerUnstableWithArgs = { home-manager.extraSpecialArgs = attrs // { inherit system; }; };
    in
    {
      nixosConfigurations = {
        frenchpenguin = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          specialArgs = attrs;
          modules = [
            ./systems/frenchpenguin
            homeManagerWithArgs
          ];
        };

        microwave = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          pkgs = mkPkgs nixpkgs-unstable;

          specialArgs = attrs // { home-manager = home-manager-unstable; };
          modules = [ ./systems/microwave homeManagerUnstableWithArgs ];
        };
      };

      homeConfigurations."matteojoliveau@frenchpenguinv5" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          (import ./home-manager/matteo/frenchpenguinv5.nix)
        ];
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
