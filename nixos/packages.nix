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

		# Virtualization
		spice
		win-spice
		spice-gtk

		# Other
		home-manager
		libreoffice
		godot_4
		qbittorrent
	];

	virtualisation.spiceUSBRedirection.enable = true;
	services.spice-vdagentd.enable = true;
	virtualisation.libvirtd.enable = true;

	programs = {
		firefox.enable = true;
		sway.enable = true;
		zsh.enable = true;
		virt-manager.enable = true;
	};

	services.openssh.enable = true;
}
