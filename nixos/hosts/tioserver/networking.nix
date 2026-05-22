{ pkgs, ... }:
{
  services.openvpn.servers.nordvpn = {
    autoStart = true;
    config = "config /home/dps/.nordvpn";
    updateResolvConf = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    trustedInterfaces = [ "tailscale0" ];
  };

  networking.enableIPv6 = false;

  services.tailscale.useRoutingFeatures = "server";
  systemd.services.ethtool-tuning = {
    description = "Enable UDP GRO forwarding for Tailscale";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      ${pkgs.ethtool}/sbin/ethtool -K enp0s20f0u4 rx-udp-gro-forwarding on
      ${pkgs.ethtool}/sbin/ethtool -K enp0s20f0u4 rx-gro-list off
      ${pkgs.ethtool}/sbin/ethtool -K eno1 rx-udp-gro-forwarding on
      ${pkgs.ethtool}/sbin/ethtool -K eno1 rx-gro-list off
    '';
  };
}
