{ pkgs, ... }:

pkgs.buildGoModule rec {
  pname = "biscuit";
  version = "v0.1.7";
  src = pkgs.fetchFromGitHub {
    owner = "primait";
    repo = pname;
    rev = version;
    sha256 = "sha256-qa6CqoVsoT+FOC/sff4K3ZyE2F3Zn3VzsMX/IBy9Jv8=";
  };

  vendorHash = "sha256-pjer2alGWDs06I3SYmeezaM1kioaRpcuk7RBrttOM8I=";
}
