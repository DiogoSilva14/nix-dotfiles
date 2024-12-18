{
	wayland.windowManager.sway = {
		wrapperFeatures.gtk = true;
	};

	xdg.configFile = {
		"sway/config" = { source = ./config; };
		"sway/wallpaper.png" = { source = ./linux_terminal_wallpaper.png; };
	};
}
