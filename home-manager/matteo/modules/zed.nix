{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;



    extensions = [
      "biome"
      "catpuccin"
      "catpuccin-icons"
      "crates-lsp"
      "csv"
      "design-tokens"
      "dockerfile"
      "docker-compose"
      "elm"
      "env"
      "fish"
      "graphql"
      "helm"
      "just"
      "just-ls"
      "nix"
      "opentofu"
      "svelte"
    ];

    userSettings = {
      autosave = "on_focus_change";
      auto_update = false;
      vim_mode = true;
      disable_ai = true;

      theme = "Catpuccin Frappé";
      icon_theme = "Catpuccin Icons";

      file_types = {
        Dockerfile = [ "*.dockerfile" "Dockerfile.*" ];
        OpenTofu = ["tf"];
        "OpenTofu Vars" = ["tfvars"];
      };

      lsp = {
        rust-analyzer = {
          settings = {
            cachePriming.enable = false;
            cargo.features = "all";
          };
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
  };
}
