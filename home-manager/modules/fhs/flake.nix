{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    fhs = pkgs.buildFHSUserEnv {
      name = "fhs-shell";
      targetPkgs = pkgs: with pkgs; [
        gcc
        glib
        gtk3
        gtk4
        jdk21
        libGL
        libtool
        xorg.libX11
        xorg.libXrandr
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libXi
        xorg.libXcursor
        xorg.libXinerama
        opencl-headers
        zlib
      ];
    };
  in {
    devShells.${system}.default = fhs.env;
  };
}
