{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.tailscale.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
