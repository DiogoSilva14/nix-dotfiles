{ pkgs, ... }:
{
	fonts.fontconfig.enable = true;
	home.packages = [
		(pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
		pkgs.font-awesome
	];
}
