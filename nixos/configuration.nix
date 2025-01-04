{
	imports = [
		./hardware-configuration.nix
		./modules/bundle.nix
		./packages.nix
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes

	networking.hostName = "nixos"; # Define hostname

	security.polkit.enable = true;
	services.gnome.gnome-keyring.enable = true;
	services.flatpak.enable = true;

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 14d";
	};

	services.openvpn.servers.nordvpn = {
		autoStart = true;
		config = "config /home/dps/.nordvpn";
		updateResolvConf = true;
	};

	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
				user = "dps";
			};
		};
	};

	system.stateVersion = "24.11"; # State version. Not sure if needed with flakes :/
}
