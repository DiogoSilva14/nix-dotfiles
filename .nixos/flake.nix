{
	description = "NixOS config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: 

		let
			system = "x86_64-linux";
		in {

		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./configuration.nix	];
		};

		homeConfigurations.dps = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [ ./home.nix ];
		};
	};
}
