pkgs:

let
  lazyactions = pkgs.callPackage ./lazyactions.nix { };
  dungeondraft = pkgs.callPackage ./dungeondraft.nix { };
  wonderdraft = pkgs.callPackage ./wonderdraft.nix { };
in
{
  overlays.default = self: super: {
    inherit lazyactions dungeondraft wonderdraft;
  };
}
