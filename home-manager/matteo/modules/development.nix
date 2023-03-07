{ pkgs, ... }:
let
  lsps = with pkgs; [
    elixir_ls
    gopls
    rust-analyzer
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
    suite-py
    # cargo-dist
  ] ++ lsps;

  programs.vscode.enable = true;
}
