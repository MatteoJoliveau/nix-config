pkgs:

let
  lazyactions = pkgs.callPackage ./lazyactions.nix { };
  dungeondraft = pkgs.callPackage ./dungeondraft.nix { };
in
{
  overlays.default = self: super: {
    inherit lazyactions dungeondraft;
  };
}
