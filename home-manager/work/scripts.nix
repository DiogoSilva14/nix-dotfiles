{
	home.packages = with pkgs; [
		(writeShellScriptBin "git-commit" (builtins.readFile ~/Documents/git-ai/git-commit))
		(writeShellScriptBin "git-review" (builtins.readFile ~/Documents/git-ai/git-review))
	];

}
