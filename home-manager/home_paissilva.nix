{ config, pkgs, ... }:
{
  imports = [
    ./modules/bundle.nix
    ./modules/bundle-gui.nix
    ./work/macros.nix
    ./work/mounts.nix
  ];

  home = {
    username = "paissilva";
    homeDirectory = "/home/paissilva";
    stateVersion = "24.11";
  };
}
