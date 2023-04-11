{ pkgs, ... }:
let
  lsps = with pkgs; [
    elixir_ls
    gopls
    unstable.rust-analyzer
  ];
in
{
  home.packages = with pkgs; [
    rustup
    httpie
    insomnia
    awscli2
    ssm-session-manager-plugin
    kubectl
    k9s
    kubectx
    kubie
    kubernetes-helm
    kustomize
    krew
    minikube
    kind
    asciinema
    jq
    yq
    ruby_3_1
    lazygit
    git-town
    doctl
    jo
    vpnc
    remmina
    velero
    google-cloud-sdk
    lapce
    nodejs
    sqlite
    postgresql
    go
    luajitPackages.luarocks
    gnumake
  ] ++ lsps;

  programs.vscode.enable = true;
}
