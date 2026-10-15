{ pkgs, ... }:
{
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  services.glances = {
    enable = true;
    openFirewall = false;
    extraArgs = [ "-w" "--bind" "127.0.0.1" ];
  };

  imports = [ ./containers/bundle.nix ];
}
