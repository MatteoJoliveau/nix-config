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
      unst = "restore --staged";
    };
    lfs.enable = true;
    delta.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
      merge = {
        conflictStyle = "diff3";
      };
    };
    includes = [
      {
        path = "~/.config/git/prima-hooks.cfg";
      }
      {
        condition = "gitdir:~/Software/prima";
        contents = {
          user = {
            name = "Matteo Joliveau";
            email = "matteo.joliveau@prima.it";
          };
        };
      }
    ];
  };
}
