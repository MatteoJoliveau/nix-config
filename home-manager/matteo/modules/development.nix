{ pkgs, ... }:
let
  lsps = with pkgs; [
    elixir_ls
    elmPackages.elm-language-server
    gopls
    marksman
    nil
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    typescript
    nodePackages.yaml-language-server
    sqls
    buf
    taplo
    python311Packages.python-lsp-server
    terraform-ls
  ];
in
{
  home.sessionVariables = {
    COMPOSE_BAKE = "true";
  };

  home.packages =
    with pkgs;
    [
      asciinema
      awscli2
      bacon
      cargo-generate
      clang
      cloudflared
      cmake
      fastmod
      gnumake
      go
      insomnia
      jetbrains.datagrip
      jo
      jq
      k9s
      kind
      krew
      kubectl
      kubectx
      kubernetes-helm
      kubie
      kustomize
      mergiraf
      minikube
      nodejs
      postgresql
      remmina
      ruby_3_1
      rustup
      sqlite
      vault-bin
      xh
      yq
      zellij
    ]
    ++ lsps;

  programs.vscode.enable = false;

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Matteo Joliveau";
        email = "matteo@matteojoliveau.com";
      };

      ui = {
        diff.tool = [
          "difft"
          "--color=always"
          "$left"
          "$right"
        ];
        diff-editor = ":builtin";
      };

      signing = {
        behavior = "own";
        backend = "gpg";
        key = "matteo@matteojoliveau.com";
      };

      aliases = {
        l = [ "log" ];
        ps = [
          "git"
          "push"
        ];
        cim = [
          "commit"
          "-m"
        ];
        bm = [
          "bookmark"
          "move"
          "--to"
        ];
        bu = [
          "bookmark"
          "move"
          "--to"
          "@-"
        ];
      };
    };
  };

  programs.starship.settings = {
    # https://github.com/jj-vcs/jj/wiki/Starship
    custom.jj = {
      command = ''
        jj log -r@ -n1 --ignore-working-copy --no-graph --color always  -T '
          separate(" ",
            bookmarks.map(|x| if(
                x.name().substr(0, 10).starts_with(x.name()),
                x.name().substr(0, 10),
                x.name().substr(0, 9) ++ "…")
              ).join(" "),
            tags.map(|x| if(
                x.name().substr(0, 10).starts_with(x.name()),
                x.name().substr(0, 10),
                x.name().substr(0, 9) ++ "…")
              ).join(" "),
            surround("\"","\"",
              if(
                 description.first_line().substr(0, 24).starts_with(description.first_line()),
                 description.first_line().substr(0, 24),
                 description.first_line().substr(0, 23) ++ "…"
              )
            ),
            if(conflict, "conflict"),
            if(divergent, "divergent"),
            if(hidden, "hidden"),
          )
        '
      '';
      when = "jj root";
      symbol = "jj";
    };

    custom.jjstate = {
      when = "jj root";
      command = ''
        jj log -r@ -n1 --no-graph -T "" --stat | tail -n1 | sd "(\d+) files? changed, (\d+) insertions?\(\+\), (\d+) deletions?\(-\)" ' $${1}m $${2}+ $${3}-' | sd " 0." ""
      '';
    };
  };
}
