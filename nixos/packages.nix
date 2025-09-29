{ pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "libfprint-2-tod1-broadcom"
    "obsidian"
    "spotify"
    "steam"
    "steam-unwrapped"
  ];


  environment.systemPackages = with pkgs; [
    # CLI
    wget
    git
    ripgrep
    btop

    # Media
    discord
    mpv
    spotify

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
    freecad
    prusa-slicer

    # Other
    home-manager
    libreoffice
    qbittorrent
    brave
    bitwarden
    obsidian
    fwupd
    obs-studio
    gimp
  ];

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-broadcom;

  virtualisation = {
#    libvirtd.enable = true;
#    spiceUSBRedirection.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs = {
    zsh.enable = true;
#    virt-manager.enable = true;
  };
}
