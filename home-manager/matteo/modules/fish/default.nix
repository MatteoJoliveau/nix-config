{ pkgs, ... }:

{
  home.packages = with pkgs; [
    starship
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      hk = "heroku";
      tf = "terraform";
      k = "kubectl";
      ktx = "kubie ctx";
      kns = "kubie ns";
      isodate = "date -u +'%Y-%m-%dT%H:%M:%SZ'";
      g = "git";
      tree = "eza -T";
      ls = "eza";
      grep = "rg";
      lg = "lazygit";
      rng = "ranger";
      cp = "cp -a --reflink=auto";
      rebar = "rebar3";
      compose = "docker compose";
      nethack = "telnet nethack.alt.org";
      ed = "emacs -nw";
      cat = "bat";
      cal = "cal -m";
      reset_bg = "eval (~/.fehbg)";
      "code." = "code .";
      hm = "home-manager";
      ecrlogin = "eval (aws ecr get-login --no-include-email)";
      sb = "sonobuoy";
      sp = "suite-py";
      v = "nvim";
    };

    interactiveShellInit = "eval (starship init fish)";

    shellInit = ''
      set -gx PATH /nix/var/nix/profiles/default/bin $HOME/.nix-profile/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/.krew/bin $PATH
      eval (direnv hook fish)
      zoxide init fish | source
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "626bd39b002535d69e56adba5b58a1060cfb6d7b";
          sha256 = "06whihwk7cpyi3bxvvh3qqbd5560rknm88psrajvj7308slf0jfd";
        };
      }
      { name = "fzf"; src = fzf-fish; }
      { name = "forgit"; src = forgit; }
    ];

    functions = {
      be = "bundle exec $argv";
      cdso = ''
        set software_path ~/Software
        if count $argv > /dev/null
          cd $software_path/$argv[1]
        else
          cd $software_path
        end
      '';
      goodnight = ''
        read -l -P 'Shutting down. Confirm? [y/N] ' confirm
    
        switch $confirm
          case Y y
            shutdown -h now
          case \'\' N n
            return 0
        end
      '';
    };
  };

  xdg.configFile = {
    "starship.toml".source = ./starship.toml;
  };

  home.file = {
    ".kube/kubie.yaml".source = ./kubie.yaml;
  };
}
