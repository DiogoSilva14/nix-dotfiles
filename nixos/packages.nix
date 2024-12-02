{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
		# CLI
		wget
		git

		# Media
		mpv
		spotify

		# Intel GPU Acceleration
		intel-media-sdk

		# Other
		home-manager
	];

	programs = {
		firefox.enable = true;
		zsh.enable = true;
	};

	services.openssh.enable = true;
}
