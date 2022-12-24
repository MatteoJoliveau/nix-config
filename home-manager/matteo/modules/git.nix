{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Matteo Joliveau";
    userEmail = "matteo@matteojoliveau.com";
    signing = {
      key = "matteo@matteojoliveau.com";
      signByDefault = true;
    };
    ignores = [ "*.iml" ".idea/" ".vscode" ".direnv" ];
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit -s";
      cim = "commit -s -m";
      cin = "commit -s -n";
      st = "status";
      aa = "add .";
      a = "add";
      pl = "pull";
      l = "log --graph --name-status";
      ps = "push";
      psu = "push -u origin HEAD";
      psf = "push --force-with-lease";
      me = "merge";
    };
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
    };
  };
}
