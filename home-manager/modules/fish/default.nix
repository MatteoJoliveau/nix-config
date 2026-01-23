{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      "code." = "code .";
      cal = "cal -m";
      cat = "bat";
      compose = "docker compose";
      cp = "cp -a --reflink=auto";
      ecrlogin = "eval (aws ecr get-login --no-include-email)";
      ed = "emacs -nw";
      fm = "fastmod";
      g = "git";
      grep = "rg";
      hk = "heroku";
      hm = "nh home";
      http = "echo Use 'xh' instead of http.";
      https = "echo Use 'xhs' instead of https.";
      isodate = "date -u +'%Y-%m-%dT%H:%M:%SZ'";
      j = "jj";
      k = "kubectl";
      kns = "kubie ns";
      ktx = "kubie ctx";
      lg = "lazygit";
      ls = "eza";
      actions = "lazyactions";
      nethack = "telnet nethack.alt.org";
      rebar = "rebar3";
      reset_bg = "eval (~/.fehbg)";
      rm = "echo Use 'rip' instead of rm.";
      rng = "ranger";
      sb = "sonobuoy";
      sp = "suite-py";
      tf = "terraform";
      tree = "eza -T";
      v = "nvim";
    };

    shellInit = ''
      fish_add_path /nix/var/nix/profiles/default/bin $HOME/.nix-profile/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/.krew/bin $HOME/.npm-packages/bin
      set -gx --path XDG_DATA_DIRS $XDG_DATA_DIRS /usr/share/glib-2.0/schemas /usr/share/ubuntu /usr/share/gnome /usr/local/share /usr/share /var/lib/flatpak/exports/share $HOME/.local/share/flatpak/exports/share
      set -gx RIP_GRAVEYARD /tmp/graveyard-$USER

      eval (direnv hook fish)
      eval (rip completions fish)
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
      {
        name = "fzf";
        src = fzf-fish;
      }
      {
        name = "forgit";
        src = forgit;
      }
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

  home.file = {
    ".kube/kubie.yaml".source = ./kubie.yaml;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableIonIntegration = false;
    enableNushellIntegration = false;
    enableTransience = false;
    enableZshIntegration = false;

    settings = {
      kubernetes.disabled = false;
    };
  };

  programs.nix-index.enableFishIntegration = true;
}
