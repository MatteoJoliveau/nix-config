{ pkgs, ... }:
let
in
{
  home.packages = with pkgs; [
    rustup
    unstable.httpie
    insomnia
    unstable.awscli2
    unstable.ssm-session-manager-plugin
    kubectl
    k9s
    kubectx
    kubie
    unstable.kubernetes-helm
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
    unstable.saml2aws
    jo
    vpnc
    remmina
    velero
    google-cloud-sdk
    httpie-desktop
  ];

  programs.vscode.enable = true;
}
