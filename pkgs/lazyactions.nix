{ buildGo124Module, fetchFromGitHub, ... }:

buildGo124Module rec {
  pname = "lazyactions";
  version = "0.0.12";

  src = fetchFromGitHub {
    owner = "nnnkkk7";
    repo = "lazyactions";
    rev = "v${version}";
    sha256 = "sha256-9mQWWi0mTpJZh7KUN5+2VM3dLbf7j/NrH8GcTkiT1d4=";
  };

  subPackages = [ "cmd/lazyactions" ];

  vendorHash = "sha256-pKKYPKOHAl7MnlwuA8byhdz/RJOJ/4XbftT07z8AIT8=";
}
