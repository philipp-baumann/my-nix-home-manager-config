{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    r-radian = {
      url = "github:swt30/radian-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils, r-radian, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let 
          username = "philipp";
          pkgs = nixpkgs.legacyPackages.${system};
          radian = r-radian.packages.${system}.radian;
        in {
          # https://github.com/nix-community/home-manager/issues/3075#issuecomment-1593969080
          packages = {
            homeConfigurations.${username} =
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ];
              };
          };
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              R
              radian
              # here you can also include other R packages you need, like:
              # rPackages.tidyverse
              # rPackages.DBI
              # rPackages.shiny
        ];
      };
        }
      );
}
