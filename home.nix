{ config, pkgs, ... }: {
  home.username = "philipp";
  home.homeDirectory = "/Users/philipp";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # import other nix files
  imports = [
    ./shell.nix
    # ./R.nix
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
      dracula-theme.theme-dracula
      bbenoist.nix
    ];
  };
  
  home.packages = with pkgs; [
    btop   
    htop   
    zip    
    unzip  
    ripgrep
    tree
    nano
    micro
    openssh
    neovim
  ];
}

