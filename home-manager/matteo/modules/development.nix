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
  home.packages = with pkgs; [
    asciinema
    awscli2
    bacon
    cargo-generate
    clang
    cloudflared
    cmake
    gnumake
    go
    httpie
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
    yq
    zellij
  ] ++ lsps;

  programs.vscode.enable = true;

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Matteo Joliveau";
        email = "matteo@matteojoliveau.com";
      };

      ui = {
        diff.tool = [ "difft" "--color=always" "$left" "$right" ];
        diff-editor = ":builtin";
      };

      aliases = {
        l = ["log"];
        ps = ["git" "push"];
        cim = ["commit" "-m"];
        ci = ["commit"];
        bm = ["bookmark" "move" "--to"];
        bu = ["bookmark" "move" "--to" "@-"];
      };
    };
  };
}
