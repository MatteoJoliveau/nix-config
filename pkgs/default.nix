pkgs:

let
  lazyactions = pkgs.callPackage ./lazyactions.nix { };
in
{
  overlays.default = self: super: {
    inherit lazyactions;
  };
}
