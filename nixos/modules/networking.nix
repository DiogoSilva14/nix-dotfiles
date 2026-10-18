{
  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "virbr0" ];
    };
  };
}
