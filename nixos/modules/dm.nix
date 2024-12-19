{
	services.displayManager = {
		defaultSession = "sway";
		sddm = {
			enable = true;
			wayland.enable = true;
		};
	};

	services.desktopManager.plasma6.enable = true;
}
