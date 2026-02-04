{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { self, nixpkgs, lanzaboote, home-manager, nixvim, catppuccin, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    mkNixos = host: isHeadless:
      nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./nixos/hosts/${host}/configuration.nix
          lanzaboote.nixosModules.lanzaboote
        ]
        ++ (if !isHeadless then [
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.dps = {
              imports = [
                ./home-manager/home_dps.nix
                nixvim.homeModules.nixvim
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ] else []);

        specialArgs = { inherit inputs; };
      };

    mkHome = file:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          file
          nixvim.homeModules.nixvim
          catppuccin.homeModules.catppuccin
        ];
      };

  in {
    nixosConfigurations = {
      tiolaptop = mkNixos "tiolaptop" false;
      tioserver = mkNixos "tioserver" true;
    };

    homeConfigurations = {
      paissilva = mkHome ./home-manager/home_paissilva.nix;
    };
  };
}
