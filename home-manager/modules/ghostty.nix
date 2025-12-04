{ ... }:

{
  programs.ghostty = {
    enable = true;

    enableFishIntegration = true;

    settings = {
      theme = "Catppuccin Macchiato";
      background-opacity = 0.85;

      keybind = [
        "alt+c=copy_to_clipboard"
        "alt+v=paste_from_clipboard"
      ];
    };
  };
}
