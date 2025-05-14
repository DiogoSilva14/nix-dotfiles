{ config, pkgs, ... }:
{
  imports = [
    ./modules/bundle.nix
  ];

  home = {
    username = "dps";
    homeDirectory = "/home/dps";
    stateVersion = "24.11";
  };
}
