{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/bundle.nix
    ../../modules/bundle-gui.nix
  ];

  networking.hostName = "tiolaptop";

  services.flatpak.enable = true;

  system.stateVersion = "25.11";
}
