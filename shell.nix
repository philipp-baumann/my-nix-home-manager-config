# Shell configuration for zsh (frequently used) and fish (used just for fun)

{ config, lib, pkgs, ... }:

let
  shellAliases = {
    ll = "ls -la";

    # Reload home manager and zsh
    reload = "home-manager switch && source ~/.zshrc";

    # Nix garbage collection
    garbage = "nix-collect-garbage -d && docker image prune --force";

    hms = "home-manager switch";

    # https://github.com/Mozilla-Ocho/llamafile?tab=readme-ov-file
    mixtral = "/usr/local/bin/mixtral-8x7b-instruct-v0.1.Q5_K_M-server.llamafile";

    newflake = "nix flake new -t github:nix-community/nix-direnv .";

    nix-ldd = "nix-shell -p stdenv.cc --pure --run 'clang++ -fuse-ld=lld /dev/null'";
    
    nixloc = "nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'"; 
    
    nixreview-head = "nix-shell -p nixpkgs-review --run 'nixpkgs-review rev HEAD'";
   
    nixreview-pr = "nix-shell -p nixpkgs-review --run 'nixpkgs-review pr --print-result'"; 
  };
in {
  # zsh settings
  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "edvardm";
    };
  };
}
