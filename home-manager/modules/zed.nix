{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.super-unstable.zed-editor;

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
      helix_mode = true;
      disable_ai = true;

      theme = "Catpuccin Frappé";
      icon_theme = "Catpuccin Icons";

      file_types = {
        Dockerfile = [
          "*.dockerfile"
          "Dockerfile.*"
        ];
        OpenTofu = [ "tf" ];
        "OpenTofu Vars" = [ "tfvars" ];
      };

      lsp = {
        rust-analyzer = {
          cachePriming.enable = false;
          cargo.features = "all";
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      base_keymap = "Emacs";

      minimap = {
        show = "auto";
        thumb = "always";
        thumb_border = "left_open";
        current_line_highlight = null;
      };

    };

    userKeymaps = [
      {
        bindings = {
          "alt-v" = "editor::Paste";
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-a" = "editor::SelectAll";
        };
      }
      {
        context = "Editor && mode == full && vim_mode != insert";
        bindings = {
          "space /" = "pane::DeploySearch";
          "u" = "editor::Undo";
          "shift-u" = "editor::Redo";
          "tab" = "editor::Indent";
          "shift-tab" = "editor::Outdent";
        };
      }
      {
        context = "Editor && mode == full && vim_mode != insert";
        bindings = {
          "space p o" = [
            "workspace::Open"
            { "create_new_window" = false; }
          ];
          "space p p" = [
            "projects::OpenRecent"
            { "create_new_window" = false; }
          ];
          "space p f" = "file_finder::Toggle";
          "x" = "editor::SelectLine";
          "space u" = "editor::Undo";
          "space shift-u" = "editor::Redo";
          "space a" = "editor::ToggleCodeActions";
          "/" = "buffer_search::Deploy";
          "space f" = "editor::Format";
        };
      }
      {
        context = "Editor && vim_mode == visual";
        bindings = {
          "y" = "editor::Copy";
          "s" = "editor::Cut";
          "c" = "editor::Delete";
          "p" = "editor::Paste";
          "r" = "editor::Paste";
          "g" = "editor::Cancel";
        };
      }
    ];
  };
}
