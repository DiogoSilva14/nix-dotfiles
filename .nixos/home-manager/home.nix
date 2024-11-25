{ config, pkgs, ... }: 
let
	nixConfigDir = "~/.nixos/";
in {
	home = {
		username = "dps";
		homeDirectory = "/home/dps";
		stateVersion = "24.11";

		packages = with pkgs; [
			neofetch
		];
	};

	programs.zsh = {
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch --flake ${nixConfigDir} && home-manager switch --flake ${nixConfigDir}";
		};
	};

	programs.neovim = {
		enable = true;
	};
}
