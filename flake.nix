{
	description = "NixOS config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:

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
			];
		};

		homeConfigurations.paissilva = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [
				./home-manager/home_paissilva.nix
				nixvim.homeManagerModules.nixvim
			];
		};
	};
}
