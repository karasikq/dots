{
  description = "Cbate's Nix configuration Manager for Arch Linux and macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
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

        # macOS configuration
        "cbate@macos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/macos.nix
            {
              home = {
                username = "cbate";
                homeDirectory = "/Users/cbate";
                stateVersion = "23.11";
              };
            }
          ];
        };
      };
    };
} 