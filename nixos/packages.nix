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
		pavucontrol
		spice
		win-spice
		spice-gtk
		libreoffice
	];

	virtualisation.spiceUSBRedirection.enable = true;
	services.spice-vdagentd.enable = true;
	virtualisation.libvirtd.enable = true;

	programs = {
		firefox.enable = true;
		virt-manager.enable = true;
		sway.enable = true;
		zsh.enable = true;
	};

	services.openssh.enable = true;
}
