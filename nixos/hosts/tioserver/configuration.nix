{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ../../modules/bundle.nix
      ../../modules/server/bundle.nix
    ];

  networking.hostName = "tioserver";
  system.stateVersion = "25.11";
}

