{ ... }:

{
  nix = {
    settings.auto-optimise-store = true;

    # Automatically cleanup derivation older than a month each week
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
