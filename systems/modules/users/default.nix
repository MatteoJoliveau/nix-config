{ ... }:

{
  users.extraUsers.root.password = "";
  users.mutableUsers = false;

  # OpenDoas
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; keepEnv = true; persist = true; }
    ];
  };
}
