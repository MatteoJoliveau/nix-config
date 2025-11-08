{
  description = "Flake for my NixOS machines";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    megasploot.url = "github:matteojoliveau/megasploot.nix";

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      home-manager,
      home-manager-unstable,
      megasploot,
      nixgl,
      noctalia,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;

        nix.registry = pkgs.lib.mapAttrs (_: value: { flake = value; }) inputs;

        overlays = [
          megasploot.overlays.default
          nixgl.overlays.default
          (self: super: {
            inherit unstable;

          # https://github.com/nix-community/home-manager/issues/322#issuecomment-1178614454
            openssh = super.openssh.overrideAttrs (old: {
              patches = (old.patches or [ ]) ++ [ ./patches/openssh.patch ];
              doCheck = false;
            });
          })
        ];
      };

      homeManagerWithArgs = {
        home-manager.extraSpecialArgs = inputs // {
          inherit system;
          unstable = home-manager-unstable;
        };
      };
    in
    {
      nixosConfigurations = {
        frenchnord = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          specialArgs = inputs;
          modules = [
            home-manager.nixosModules.home-manager
            homeManagerWithArgs
            ./nixos/systems/frenchnord/configuration.nix
          ];
        };
      };

      homeConfigurations."matteojoliveau@frenchpenguin" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit nixgl noctalia; };

        modules = [
          (import ./home-manager/systems/prima-laptop)
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
            nixfmt-tree
          ];
        };
      }
    );
}
