{
  description = "Cbate's Nix configuration Manager for Arch Linux and macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        # Arch Linux configuration
        "cbate@arch" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/arch.nix
            {
              home = {
                username = "cbate";
                homeDirectory = "/home/cbate";
                stateVersion = "23.11";
              };
            }
          ];
        };
      };

      # Add system-level nix-darwin configuration for macOS
      darwinConfigurations = {
        "cbate-mac" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cbate = import ./home-manager/macos.nix;
            }
          ];
        };
      };
    };
} 