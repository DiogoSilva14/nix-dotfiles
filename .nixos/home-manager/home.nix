{ config, pkgs, ... }: 
{
	imports = [
		./zsh.nix
		./modules/bundle.nix
	];

	home = {
		username = "dps";
		homeDirectory = "/home/dps";
		stateVersion = "24.11";

		packages = with pkgs; [
			neofetch
		];
	};

	programs.neovim = {
		enable = true;
	};
}
