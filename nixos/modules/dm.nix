{
	services.displayManager = {
		defaultSession = "sway";
		sddm = {
			enable = true;
			wayland.enable = true;
		};
	};
	programs.xwayland.enable = true;
}
