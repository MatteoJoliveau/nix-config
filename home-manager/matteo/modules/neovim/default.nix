{ pkgs, lib, ... }:

{
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraPackages = with pkgs; [
            gcc
            go
            unzip
        ];

        plugins = with pkgs.vimPlugins; [
            vim-nix
            vim-elixir
            auto-save-nvim 
        ];
    };

    # From https://github.com/nvim-lua/kickstart.nvim
    xdg.configFile."nvim/init.lua".source = ./kickstart.lua;
}
