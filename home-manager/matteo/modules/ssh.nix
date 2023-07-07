{ ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "web-1.quilltrace.dev" = {
        hostname = "38.242.130.176";
        port = 1299;
        user = "deploy";
      };
    };
  };
}
