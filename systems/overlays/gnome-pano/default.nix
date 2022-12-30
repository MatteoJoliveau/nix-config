{ pano-overlay }:

self: super:

{
  gnomeExtensions = super.gnomeExtensions // {
    pano = super.callPackage "${pano-overlay}/pkgs/desktops/gnome/extensions/pano"
      { };
  };
}

