{ config, ... }:
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases =
		let
			flakeDir = "~/nix-dotfiles";
			fhsDir = "${flakeDir}/home-manager/modules/fhs";
		in {
			rebuild = "sudo nixos-rebuild switch --flake ${flakeDir} && home-manager switch --flake ${flakeDir}";
			hms = "nix run nixpkgs#home-manager -- switch --flake ${flakeDir}";
			fhs = "nix develop ${fhsDir}";

			fd = "cd ${flakeDir}";

			v = "nvim";
		};

		history.size = 10000;
		history.path = "${config.xdg.dataHome}/zsh/history";

		oh-my-zsh = {
			enable = true;
			plugins = [
				"git"
				"sudo"
				"fzf"
			];
			theme = "agnoster";
		};

		initExtra = "
			if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
				. ~/.nix-profile/etc/profile.d/nix.sh
			fi

			export PATH=$PATH:~/.local/bin
		";
	};
}
