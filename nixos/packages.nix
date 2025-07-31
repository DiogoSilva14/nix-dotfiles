{ pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
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
  ];
#  services.spice-vdagentd.enable = true;

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
