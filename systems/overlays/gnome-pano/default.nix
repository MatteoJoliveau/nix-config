self: super:

let
  pname = "gnome-shell-extension-pano";
  version = "10";
  uuid = "pano@elhan.io";

  girpathsPatch = (super.substituteAll {
    src = ./set-dirpaths.patch;
    gda_path = "${super.libgda}/lib/girepository-1.0";
    gsound_path = "${super.gsound}/lib/girepository-1.0";
  });

  panoSource = super.fetchFromGitHub {
    owner = "oae";
    repo = "gnome-shell-pano";
    rev = "v${version}";
    hash = "sha256-1vGiWSXlQ8xheqJsZm3uXCixuLl5NFM2OgPQrzCPhME=";
  };

  yarnNix = super.stdenv.mkDerivation {
    inherit pname version;
    name = "gnome-shell-extension-pano-yarn-nix-${version}";
    src = panoSource;

    nativeBuildInputs = with super; [
      yarn2nix
    ];

    buildPhase = ''
      yarn2nix >yarn.nix
    '';

    installPhase = ''
      mkdir -p "$out"
      cp -p package.json yarn.lock yarn.nix "$out/"
    '';
  };
in
{
  gnomeExtensions = super.gnomeExtensions // {
    pano = super.callPackage "${
    builtins.fetchTarball "https://github.com/michojel/nixpkgs/archive/gnome-shell-extension-pano.tar.gz"
  }/pkgs/desktops/gnome/extensions/pano"
      { };
  };
}

