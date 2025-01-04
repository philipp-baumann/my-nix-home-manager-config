{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    catppuccin-vsc.url = "github:catppuccin/vscode";
    r-radian = {
      url = "github:swt30/radian-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils, r-radian, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          # https://github.com/nix-community/home-manager/issues/3075#issuecomment-1593969080
          packages = {
            homeConfigurations."philipp-${system}" =
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                  ./home.nix
                  {
                     home.username = "philipp";
                     home.homeDirectory = "/Users/philipp";
                  }
                ];
              };
            homeConfigurations."spectral-cockpit-${system}" =
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                  ./home.nix
                  {
                     home.username = "spectral-cockpit";
                     home.homeDirectory = "/home/spectral-cockpit";
                  }
                ];
              };
          };
        }
      );
}
