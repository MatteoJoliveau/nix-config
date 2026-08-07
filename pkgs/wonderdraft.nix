{
  stdenv,
  pkgs,
  lib,
  requireFile,
  ...
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
    alsa-lib
    pulseaudio
    libz
    krb5.dev
    zenity
    udev
  ];
in
stdenv.mkDerivation rec {
  pname = "wonderdraft";
  version = "1.1.8.2-b";

  src = requireFile {
    name = "Wonderdraft-${version}-Linux64.zip";
    sha256 = "1hz8xb77nzgzncmnrwfn6n8ynrp9g79pmklcgw7nycw0ji6rb38j";
    url = "https://wonderdraft.net";
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

    substituteInPlace Wonderdraft.desktop \
      --replace-fail "/opt/Wonderdraft/Wonderdraft.x86_64" "$out/bin/wonderdraft" \
      --replace-fail "/opt/Wonderdraft" "$out"

    install -Dm655 -t $out/share/applications Wonderdraft.desktop
    install -Dm755 Wonderdraft.x86_64 $out/bin/wonderdraft
    install -Dm655 -t $out Wonderdraft.pck
    install -Dm655 -t $out/Wonderdaft.EULA.txt EULA.txt
    install -Dm655 -t $out Wonderdraft.png

    install -Dm755 -t $out Wonderdraft.x86_64
    makeWrapper $out/Wonderdraft.x86_64 $out/bin/wonderdraft \
      --run "cd $out" \
      --prefix PATH : ${lib.makeBinPath [ pkgs.zenity ]} \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath libraries}

    runHook postInstall
  '';
}
