{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    download-falcon-sensor
  ];

  prima.crowdstrike-falcon = {
    enable = true;
    cid = "D4EDFBE5EBA84A68A94268C9FEA40D8F-C0";
  };
}
