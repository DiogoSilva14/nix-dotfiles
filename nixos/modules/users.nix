{ pkgs, ... }: {
	users.users.dps = {
		isNormalUser = true;
		description = "dps";
		extraGroups = [ "networkmanager" "wheel" "plugdev" "libvirtd" ];
		shell = pkgs.zsh;
	};
}
