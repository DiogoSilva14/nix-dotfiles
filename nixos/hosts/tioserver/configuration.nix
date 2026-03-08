{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/bundle.nix
      ../../modules/server-services.nix
    ];

  networking.hostName = "tioserver";
  system.stateVersion = "25.11";
}

