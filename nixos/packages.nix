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

		# Dev
		distrobox
		dive
		podman-tui
		podman-compose

		# Other
		home-manager
		libreoffice
		qbittorrent
	];

	services.spice-vdagentd.enable = true;
	
	virtualisation = {
		libvirtd.enable = true;
		spiceUSBRedirection.enable = true;

		podman = {
			enable = true;
			dockerCompat = true;
			defaultNetwork.settings.dns_enabled = true;
		};
	};

	programs = {
		firefox.enable = true;
		sway.enable = true;
		zsh.enable = true;
		virt-manager.enable = true;
	};

	services.openssh.enable = true;
}
