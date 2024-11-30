{ config, ... }: 
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases =
		let
			flakeDir = "~/.nixos";
		in {
			rebuild = "sudo nixos-rebuild switch --flake ${flakeDir} && home-manager switch --flake ${flakeDir}";
			hms = "home-manager switch --flake ${flakeDir}";

			fd = "cd ${flakeDir}";

			v = "nvim";
		};

		history.size = 10000;
		history.path = "${config.xdg.dataHome}/zsh/history";

		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "sudo" ];
			theme = "agnoster";
		};
	};
}
