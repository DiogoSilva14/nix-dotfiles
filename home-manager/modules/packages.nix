{ pkgs, ... }:
{
	home.packages = with pkgs; [
		neofetch
		fortune
		uv
		fzf
		
		(pkgs.python311.withPackages (ppkgs: [
			ppkgs.ollama
		]))
	];
}
