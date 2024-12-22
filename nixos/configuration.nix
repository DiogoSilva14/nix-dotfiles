{
	imports = [
		./hardware-configuration.nix
		./modules/bundle.nix
		./packages.nix
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes

	networking.hostName = "nixos"; # Define hostname

	security.polkit.enable = true;

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 14d";
	};

	system.stateVersion = "24.11"; # State version. Not sure if needed with flakes :/
}
