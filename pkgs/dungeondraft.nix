{ stdenv
, pkgs
, lib
, requireFile
, ...
}:

let
  libraries = with pkgs; [
    libxcursor
    libxinerama
    libxext
    libxrandr
    libxrender
    libx11
    libGL
    libxi
    libz
    krb5.dev
    zenity
    udev
  ];
in
stdenv.mkDerivation rec {
  pname = "dungeondraft";
  version = "1.2.0.1";

  src = requireFile {
    name = "Dungeondraft-${version}-Linux64.zip";
    sha256 = "09n02j9hnl89dnv3paz5cfzhplzcgmami7lqwa3aswcjfpnm1hs8";
    url = "https://dungeondraft.net";
  };

  nativeBuildInputs = with pkgs; [
    unzip
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = libraries;

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
  runHook preInstall

  mkdir -p $out/bin
  mkdir -p $out/share/applications

  substituteInPlace Dungeondraft.desktop \
    --replace-fail "/opt/Dungeondraft/Dungeondraft.x86_64" "$out/bin/dungeondraft" \
    --replace-fail "/opt/Dungeondraft" "$out"

  install -Dm655 -t $out/share/applications Dungeondraft.desktop
  install -Dm755 Dungeondraft.x86_64 $out/bin/dungeondraft
  install -Dm655 -t $out Dungeondraft.pck
  install -Dm655 -t $out EULA.txt
  install -Dm655 -t $out example_template.zip
  install -Dm655 -t $out Dungeondraft.png
  cp -r data_Dungeondraft $out/
  cp -r translations $out
  cp -r mods $out

  install -Dm755 -t $out Dungeondraft.x86_64
  makeWrapper $out/Dungeondraft.x86_64 $out/bin/dungeondraft \
    --run "cd $out" \
    --prefix PATH : ${lib.makeBinPath [pkgs.zenity]} \
    --set LD_LIBRARY_PATH ${lib.makeLibraryPath libraries}

  runHook postInstall
'';
}
