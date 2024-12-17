{ config, pkgs, ... }:
{
	imports = [
		./modules/bundle.nix
	];

	home = {
		username = "paissilva";
		homeDirectory = "/home/paissilva";
		stateVersion = "24.11";
	};
}
