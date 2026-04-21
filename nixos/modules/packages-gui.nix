{ pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "libfprint-2-tod1-broadcom"
    "obsidian"
    "spotify"
  ];

  environment.systemPackages = with pkgs; [
    # Media
    mpv
    deezer-enhanced

    # Dev
    freecad
    prusa-slicer

    # Other
    grim
    thunderbird
    libreoffice
    qbittorrent
    firefox
    bitwarden-desktop
    obsidian
    obs-studio
    gimp
  ];

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-broadcom;
}
