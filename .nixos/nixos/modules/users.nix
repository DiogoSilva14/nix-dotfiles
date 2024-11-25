{ pkgs, ... }: {
	users.users.dps = {
		isNormalUser = true;
		description = "dps";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};
}
