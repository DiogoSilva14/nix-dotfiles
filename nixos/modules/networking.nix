{
  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
    };
  };

  services.openvpn.servers.nordvpn = {
    autoStart = true;
    config = "config /home/dps/.nordvpn";
    updateResolvConf = true;
  };

}
