{ pkgs, lib, ... }:
let
  rebuild = pkgs.writeTextFile {
    name = "rebuild";
    destination = "/bin/rebuild";
    executable = true;

    text = ''
      sudo nixos-rebuild switch --flake ~/nix-dotfiles#$(hostname)
    '';
  };
  rebuildEncrypt = pkgs.writeTextFile {
    name = "rebuildEncrypt";
    destination = "/bin/rebuildEncrypt";
    executable = true;

    text = ''
      sudo nixos-rebuild switch --flake ~/nix-dotfiles#$(hostname) && luksCryptenroller
    '';
  };
  luksCryptenroller = pkgs.writeTextFile {
    name = "luksCryptenroller";
    destination = "/bin/luksCryptenroller";
    executable = true;

    text = let
      luksDevice01 = "/dev/disk/by-label/NIXLUKS";
    in ''
      sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+2+7+12 ${luksDevice01}
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    # CLI
    wget
    git
    ripgrep
    btop
    screen
    socat
    rkdeveloptool

    # Virtualization
    spice
    win-spice
    spice-gtk

    # Dev
    distrobox
    podman-tui
    podman-compose

    # Other
    rebuild
    rebuildEncrypt
    luksCryptenroller
    vim
    wget
    sbctl
    tpm2-tss
  ];

  environment.etc."screenrc".text = ''
    defscrollback 10000
  '';

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  services.fwupd.enable = true;

  programs = {
    zsh.enable = true;
  };
}
