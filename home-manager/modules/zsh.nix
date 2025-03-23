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
			nix-up = "
				cd ${flakeDir} &&
				nix flake update &&
				git add flake.lock &&
				git commit -m \"Update\" &&
				git push;
				cd -
			";
			fhs = "nix develop ${fhsDir}";

			fd = "cd ${flakeDir}";

			v = "nvim";

			# Tired of 'xterm-kitty': unknown terminal type
			ssh = "export TERM=tmux; ssh";
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

			mkdir -p ~/Pictures/screenshots
			export XDG_SCREENSHOTS_DIR=~/Pictures/screenshots

			export PATH=$PATH:~/.local/bin
		";
	};
}
