{ stdenv
, lib
, pkgs
, makeWrapper
, mkPython
}:

let
  version = "1.37.4";
  suite-py = mkPython {
    requirements = "suite-py";
    python = "python310";
  };
in
stdenv.mkDerivation rec {
  name = "suite-py";

  inherit version;

  src = [ suite-py ];
  patches = [ ./suite-py.patch ];

  phases = [ "installPhase" ];

  nativeBuildInputs = [ makeWrapper pkgs.bash ];

  installPhase = with pkgs; ''
    mkdir -p $out/bin
    install -m755 -D $src/bin/suite-py $out/bin/${name}
    wrapProgram $out/bin/${name} \
      --set PATH ${lib.makeBinPath [ python310Packages.pip ]}
  '';

  meta = with lib; {
    homepage = "https;//github.com/primait/suite_py";
    description = "Suite-py is the development tool used in prima to work on projects.";
    platforms = platforms.linux;
    license = licenses.unfree;
  };
}
