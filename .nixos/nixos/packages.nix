{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
		# CLI
		wget
		git

		# Other
		home-manager
	];

	programs = {
		firefox.enable = true;
		zsh.enable = true;
	};

	services.openssh.enable = true;
}
