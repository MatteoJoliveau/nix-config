{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule
rec {
  pname = "krew";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = pname;
    rev = "v${version}";
    sha256 = "1pwnkg7qsyixj2h8rrdcwyvsqpdvc7q1jd8d62jwbrp3ga8h337r";
  };

  vendorHash = "sha256-49kWaU5dYqd86DvHi3mh5jYUQVmFlI8zsWtAFseYriE=";

  subPackages = [ "cmd/krew" ];

  meta = with lib; {
    description = "Find and install kubectl plugins ";
    longDescription = ''
      Krew is the package manager for kubectl plugins.
    '';
    homepage = "https://krew.sigs.k8s.io";
    license = licenses.asl20;
    maintainers = [
      lib.maintainers.matteojoliveau
    ];
  };
}
