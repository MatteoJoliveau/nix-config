{ pkgs, ... }:
let
  lsps = with pkgs; [
    # rust-analyzer # already installed by rustup
    elixir_ls
    elmPackages.elm-language-server
    gopls
    marksman
    nil
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
  ];
in
{
  home.packages = with pkgs; [
    asciinema
    awscli2
    bacon
    biscuit
    doctl
    git-town
    gnumake
    go
    google-cloud-sdk
    httpie
    insomnia
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
    lapce
    lazygit
    luajitPackages.luarocks
    minikube
    nodejs
    postgresql
    remmina
    ruby_3_1
    rustup
    sqlite
    ssm-session-manager-plugin
    suite_py
    velero
    vpnc
    yq
  ] ++ lsps;

  programs.vscode.enable = true;
}
