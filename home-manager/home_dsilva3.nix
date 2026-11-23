{ config, pkgs, lib, ... }:
let
  # This machine is Ubuntu, not NixOS. Nix's dynamic loader looks for its
  # ld.so.cache inside the nix store, so nix's libglvnd cannot find the system
  # EGL vendor and kitty fails with "Failed to initialize EGL". Pointing
  # libglvnd at Mesa from the same nixpkgs gives it a vendor it can load.
  kitty = pkgs.symlinkJoin {
    name = "kitty-wrapped";
    paths = [ pkgs.kitty ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/kitty \
        --set __EGL_VENDOR_LIBRARY_FILENAMES "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
    '';
  };
in
{
  imports = [
    ./modules/bundle.nix
    ./modules/bundle-gui.nix
  ];

  programs.kitty = {
    package = kitty;
    settings.shell = "${pkgs.zsh}/bin/zsh";
  };

  # Work machine: same name as modules/git.nix, but the work email.
  programs.git.settings.user.email = lib.mkForce "dsilva3@snapchat.com";

  home = {
    username = "dsilva3";
    homeDirectory = "/home/dsilva3";
    stateVersion = "24.11";
  };
}
