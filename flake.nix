{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.11";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, catppuccin, ... }@inputs:

    let
      system = "x86_64-linux";
    in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./nixos/configuration.nix ];
    };

    homeConfigurations.dps = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./home-manager/home_dps.nix
        nixvim.homeManagerModules.nixvim
        catppuccin.homeModules.catppuccin
      ];
    };

    homeConfigurations.paissilva = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./home-manager/home_paissilva.nix
        nixvim.homeManagerModules.nixvim
        catppuccin.homeModules.catppuccin
      ];
    };
  };
}
