{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # CLI
    wget
    git
    ripgrep
    nvtopPackages.intel

    # Media
    discord
    mpv
    spotify

    # Intel GPU Acceleration
    intel-media-sdk

    # Virtualization
    spice
    win-spice
    spice-gtk

    # Dev
    godot_4
    distrobox
    dive
    podman-tui
    podman-compose

    # Other
    home-manager
    libreoffice
    qbittorrent
    brave
    bitwarden
  ];

  services.spice-vdagentd.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs = {
    zsh.enable = true;
    virt-manager.enable = true;
  };
}
