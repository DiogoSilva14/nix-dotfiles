{ pkgs, ... }:
{
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  systemd.services.glances = {
    description = "Glances system monitor";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.glances}/bin/glances -w";
      Restart = "always";
    };
  };

  imports = [ ./containers/bundle.nix ];
}
