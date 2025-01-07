{ pkgs, ... }:
{
	home.packages = with pkgs; [
		neofetch
		networkmanagerapplet
		blueman
		nemo
		pavucontrol
		swaylock
		
		(pkgs.python311.withPackages (ppkgs: [
			ppkgs.ollama
		]))

		slurp
		grim
		imagemagick
	];
}
