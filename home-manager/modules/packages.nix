{ pkgs, ... }:
{
	home.packages = with pkgs; [
		neofetch
		networkmanagerapplet
		nemo
		python3
		pavucontrol
	];
}
