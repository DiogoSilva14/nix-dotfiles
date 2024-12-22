{
	wayland.windowManager.sway = {
		wrapperFeatures.gtk = true;
	};

	services.gnome-keyring.enable = true;

	xdg.configFile = {
		"sway/config" = { source = ./config; };
		"sway/wallpaper.png" = { source = ./linux_terminal_wallpaper.png; };
	};
}
