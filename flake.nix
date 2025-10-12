{
  description = "Flake for my NixOS machines";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-super-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

#     suite-py.url = "suite-py";

    megasploot.url = "github:matteojoliveau/megasploot.nix";

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-super-unstable,
      flake-utils,
      home-manager,
      home-manager-unstable,
#       suite-py,
      megasploot,
      nixgl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      super-unstable = import nixpkgs-super-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      mkPkgs =
        channel:
        import channel {
          inherit system;

          config.allowUnfree = true;

          nix.registry = pkgs.lib.mapAttrs (_: value: { flake = value; }) inputs;

          overlays = [
#             suite-py.overlays.default
            megasploot.overlays.default
            nixgl.overlays.default
            (self: super: {
              inherit unstable super-unstable;

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
      homeManagerWithArgs = {
        home-manager.extraSpecialArgs = inputs // {
          inherit system;
        };
      };
      homeManagerUnstableWithArgs = {
        home-manager.extraSpecialArgs = inputs // {
          inherit system;
        };
      };
    in
    {
      nixosConfigurations = {
        frenchnord = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          specialArgs = inputs;
          modules = [
            ./systems/frenchnord/configuration.nix
            homeManagerWithArgs
          ];
        };
      };

      homeConfigurations."matteojoliveau@frenchpenguinv5" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit nixgl; };

        modules = [
          (import ./home-manager/matteo/frenchpenguinv5.nix)
        ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        formatter = pkgs.nixfmt-tree;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
          ];
        };
      }
    );
}
