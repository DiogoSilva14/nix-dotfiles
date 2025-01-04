{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
		# CLI
		wget
		git
		ripgrep

		# Media
		discord
		mpv
		spotify

		# Intel GPU Acceleration
		intel-media-sdk

		# Other
		home-manager
		libreoffice
		godot_4
		qbittorrent
	];

	programs = {
		firefox.enable = true;
		sway.enable = true;
		zsh.enable = true;
	};

	services.openssh.enable = true;
}
