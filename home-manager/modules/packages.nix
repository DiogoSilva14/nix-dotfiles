{ pkgs, ... }:
{
	home.packages = with pkgs; [
		neofetch
		fortune
		networkmanagerapplet
		blueman
		nemo
		pavucontrol
		swaylock
		uv
		
		(pkgs.python311.withPackages (ppkgs: [
			ppkgs.ollama
		]))

		slurp
		grim
		sway-contrib.grimshot
		imagemagick
		fzf
	];
}
