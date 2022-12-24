{ pkgs, ... }:
let
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
    saml2aws
    jo
    vpnc
    remmina
    velero
    google-cloud-sdk
    # httpie-desktop
  ];

  programs.vscode.enable = true;
}
