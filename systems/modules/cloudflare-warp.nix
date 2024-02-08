{ pkgs, ... }:

let
  cloudflare-ca = pkgs.fetchurl {
    url = "https://developers.cloudflare.com/cloudflare-one/static/Cloudflare_CA.pem";
    sha256 = "sha256-7p2+Y657zy1TZAsOnZIKk+7haQ9myGTDukKdmupHVNX=";
  };
in
{
  environment.systemPackages = with pkgs; [ cloudflare-warp ];
  systemd.packages = with pkgs; [ cloudflare-warp ];

  security.pki.certificateFiles = [ cloudflare-ca ];
}
