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
    ignores = [
      "*.iml"
      ".idea/"
      ".vscode"
      ".direnv"
    ];
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
      wops = "!git add . && git commit --amend";
    };
    lfs.enable = true;
    difftastic.enable = true;
    attributes = [
      "*.java merge=mergiraf"
      "*.rs merge=mergiraf"
      "*.go merge=mergiraf"
      "*.js merge=mergiraf"
      "*.jsx merge=mergiraf"
      "*.json merge=mergiraf"
      "*.yml merge=mergiraf"
      "*.yaml merge=mergiraf"
      "*.toml merge=mergiraf"
      "*.html merge=mergiraf"
      "*.htm merge=mergiraf"
      "*.xhtml merge=mergiraf"
      "*.xml merge=mergiraf"
      "*.c merge=mergiraf"
      "*.h merge=mergiraf"
      "*.cc merge=mergiraf"
      "*.cpp merge=mergiraf"
      "*.hpp merge=mergiraf"
      "*.cs merge=mergiraf"
      "*.dart merge=mergiraf"
      "*.scala merge=mergiraf"
      "*.sbt merge=mergiraf"
      "*.ts merge=mergiraf"
      "*.py merge=mergiraf"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      merge.mergiraf = {
        name = "mergiraf";
        driver = "mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P";
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
            email = "matteo.joliveau@helloprima.com";
          };
        };
      }
    ];
  };
}
