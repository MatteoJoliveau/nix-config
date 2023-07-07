{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ cloudflare-warp ];
  systemd.packages = with pkgs; [ cloudflare-warp ];
}
