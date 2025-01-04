{
  config,
  pkgs,
  lib,
  ...
}:
let
  fromGitHub =
    rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };

in
{
  home.username = "philipp";
  home.homeDirectory = "/Users/philipp";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # import other nix files
  imports = [
    ./shell.nix
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Philipp Baumann";
    userEmail = "baumann-philipp@protonmail.com";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      # dracula-theme.theme-dracula
      bbenoist.nix
      catppuccin.catppuccin-vsc
    ];
  };

  # https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = (fromGitHub "60fce21bb6c49fe67fbe9ec174c319f01903907e" "main" "R-nvim/R.nvim");
        config = "";
      }
      {
        plugin = (
          pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
            p.r
            p.markdown
            p.markdown_inline
            p.rnoweb
          ])
        );
        config = "";
      }
    ];
    extraConfig = ''
      let mapleader = ";"
      let maplocalleader = ","
    '';
    # Use the Nix package search engine to find
    # even more plugins : https://search.nixos.org/packages
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "elixir"
      "make"
      "r"
    ];

    ## everything inside of these brackets are Zed options.
    userSettings = {
      auto_install_extensions = {
        r = true; # Enable auto-installation of the R extension
      };

      assistant = {
        enabled = true;
        version = "2";
        default_open_ai_model = null;
        ### PROVIDER OPTIONS
        ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
        ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
        ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };

        # inline_alternatives = [
        #   {
        #     provider = "copilot_chat";
        #     model = "gpt-3.5-turbo";
        #   }
        #                ];
      };

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "alacritty";
        };
        font_family = "FiraCode Nerd Font";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        #{
        #                    program = "zsh";
        #};
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      lsp = {
        rust-analyzer = {

          binary = {
            # path = lib.getExe pkgs.rust-analyzer;
            path_lookup = true;
          };
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };

        elixir-ls = {
          binary = {
            path_lookup = true;
          };
          settings = {
            dialyzerEnabled = true;
          };
        };
      };

      languages = {
        "Elixir" = {
          language_servers = [
            "!lexical"
            "elixir-ls"
            "!next-ls"
          ];
          format_on_save = {
            external = {
              command = "mix";
              arguments = [
                "format"
                "--stdin-filename"
                "{buffer_path}"
                "-"
              ];
            };
          };
        };
        "HEEX" = {
          language_servers = [
            "!lexical"
            "elixir-ls"
            "!next-ls"
          ];
          format_on_save = {
            external = {
              command = "mix";
              arguments = [
                "format"
                "--stdin-filename"
                "{buffer_path}"
                "-"
              ];
            };
          };
        };
      };

      vim_mode = true;
      ## tell zed to use direnv and direnv can use a flake.nix enviroment.
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
      show_whitespaces = "all";
      ui_font_size = 16;
      buffer_font_size = 16;

    };

  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        # draw_bold_text_with_bright_colors = false;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  fonts.fontconfig.enable = true;

  programs.borgmatic.backups = {
    personal = {
      location = {
        sourceDirectories = [ "/home/me/personal" ];
        repositories = [ "ssh://myuser@myserver.com/./personal-repo" ];
      };
    };
  };

  home.packages = with pkgs; [
    btop
    htop
    zed-editor
    borgmatic
    docker
    lima
    zip
    unzip
    ripgrep
    bat
    tree
    nano
    micro
    sshfs
    openssh
    fuse
    # need to install MacFuse: https://github.com/NixOS/nixpkgs/issues/158673
    sshfs-fuse
    thefuck
    nerd-fonts.fira-code
  ];
}
