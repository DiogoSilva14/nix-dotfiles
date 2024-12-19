{ pkgs, ... }:
{
	programs.fuzzel = {
		enable = true;
		
		settings = {
			main = {
				terminal = "${pkgs.kitty}/bin/kitty";
				layer = "overlay";
			};
			colors.background = "ffffffff";
		};
	};
}