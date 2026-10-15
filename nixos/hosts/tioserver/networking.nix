{ pkgs, ... }:
{
  services.openvpn.servers.nordvpn = {
    autoStart = true;
    config = "config /home/dps/.nordvpn";
    updateResolvConf = true;
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ ];
    allowedTCPPorts = [ 22 ];
    interfaces."tailscale0" = {
      allowedTCPPorts = [
        443
      ];
    };
  };

  networking.enableIPv6 = false;

  services.tailscale = {
    useRoutingFeatures = "server";
    extraUpFlags = [ "--netfilter-mode=nodivert" ];
  };

  systemd.services.ethtool-tuning = {
    description = "Enable UDP GRO forwarding for Tailscale";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      ${pkgs.ethtool}/sbin/ethtool -K eno1 rx-udp-gro-forwarding on
      ${pkgs.ethtool}/sbin/ethtool -K eno1 rx-gro-list off
    '';
  };

  networking.nameservers = [ "127.0.0.1" ];
}
