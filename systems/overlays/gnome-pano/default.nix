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
    pano = super.stdenv.mkDerivation rec {
      inherit pname version;

      src = panoSource;

      nativeBuildInputs = with super; [
        gobject-introspection
        nodePackages.rollup
        nodePackages.yarn
      ];

      buildInputs = with super; [
        atk
        cogl
        glib
        gsound
        gnome.gnome-shell
        gnome.mutter
        gtk3
        libgda
        pango
      ];

      nodeModules = super.mkYarnModules {
        inherit pname version; # it is vitally important the the package.json has name and version fields
        name = "gnome-shell-extension-pano-modules-${version}";
        packageJSON = "${src}/package.json";
        yarnLock = "${src}/yarn.lock";
        yarnNix = "${yarnNix}/yarn.nix";
      };

      postPatch = ''
        substituteInPlace resources/metadata.json \
          --replace '"version": 999' '"version": ${version}' 
      '';

      buildPhase =
        let
          dataDirPaths = super.lib.concatStringsSep ":" [
            "${super.gnome.gnome-shell}/share/gnome-shell"
            "${super.gnome.mutter}/lib/mutter-10"
          ];
        in
        ''
          runHook preBuild

          ln -sv "${nodeModules}/node_modules" node_modules
          export XDG_DATA_DIRS="${dataDirPaths}:$XDG_DATA_DIRS"
          yarn build
          patch -d dist -p1 < ${girpathsPatch}

          runHook postBuild
        '';

      passthru = {
        extensionUuid = uuid;
        extensionPortalSlug = "pano";
      };

      installPhase = ''
        runHook preInstall
        mkdir -p "$out/share/gnome-shell/extensions/${uuid}"
        cp -r dist/* "$out/share/gnome-shell/extensions/${uuid}/"
        runHook postInstall
      '';

      meta = with super.lib; {
        description = "Next-gen Clipboard Manager for Gnome Shell";
        license = licenses.gpl2Plus;
        platforms = platforms.linux;
        maintainers = [ maintainers.michojel ];
        homepage = "https://github.com/oae/gnome-shell-pano";
      };
    };
  };
}

