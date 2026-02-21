{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hledger
    hledger-ui
    hledger-web
    puffin
  ];

  home.sessionVariables = {
    LEDGER_FILE = "$HOME/Ledger/main.journal";
  };
}
