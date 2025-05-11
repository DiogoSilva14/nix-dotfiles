{
  networking = {
    networkmanager.enable = true;
  };
  services.openvpn.servers.nordvpn = {
    autoStart = true;
    config = "config /home/dps/.nordvpn";
    updateResolvConf = true;
  };

}
