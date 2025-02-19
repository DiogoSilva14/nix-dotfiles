{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};
	outputs = { self, nixpkgs }: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
		fhs = pkgs.buildFHSUserEnv {
			name = "fhs-shell";
			targetPkgs = pkgs: [
				pkgs.gcc
				pkgs.libtool
				pkgs.jdk21
				pkgs.zlib
				pkgs.xorg.libX11
				pkgs.gtk3
				pkgs.gtk4
				pkgs.glib
				pkgs.xorg.libXtst
			];
		};
	in {
		devShells.${system}.default = fhs.env;
	};
}
