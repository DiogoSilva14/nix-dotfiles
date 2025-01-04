{ pkgs, ... }:
{
	home.packages = with pkgs; [
		neofetch
		networkmanagerapplet
		blueman
		nemo
		python3
		pavucontrol
		swaylock
	];
}
