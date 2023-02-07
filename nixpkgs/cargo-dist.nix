{ naersk, fetchFromGitHub, ... }:

naersk.buildPackage rec {
  name = "cargo-dist";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "axodotdev";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-7/TUk9LGwmHhKwFtwFQM7C/1ItRsoJ4IodeUPWfGjkc=";
  };

}
