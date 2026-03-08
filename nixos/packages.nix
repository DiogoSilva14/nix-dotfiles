{ pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "libfprint-2-tod1-broadcom"
    "obsidian"
  ];

  environment.systemPackages = with pkgs; [
    # CLI
    wget
    git
    ripgrep
    btop

    # Media
    mpv
    deezer-enhanced

    # Virtualization
    spice
    win-spice
    spice-gtk

    # Dev
    distrobox
    podman-tui
    podman-compose
    freecad
    prusa-slicer

    # Other
    flameshot
    thunderbird
    home-manager
    libreoffice
    qbittorrent
    firefox
    bitwarden-desktop
    obsidian
    fwupd
    obs-studio
    gimp
    rkdeveloptool
    screen
    socat
  ];

  environment.etc."screenrc".text = ''
    defscrollback 10000
  '';

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-broadcom;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs = {
    zsh.enable = true;
  };
}
