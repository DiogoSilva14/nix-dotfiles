{
  virtualisation.oci-containers.containers = {
    qbittorrent = {
      image = "lscr.io/linuxserver/qbittorrent:5.2.1";

      autoStart = true;

      volumes = [
        "/data/downloads:/downloads"
        "/data/containers/qbittorrent/appdata:/config"
      ];

      environment = {
        PUID = "1000";
        PGID = "1000";
        WEBUI_PORT = "8090";
      };

      extraOptions = [ "--network=host" ];
    };
  };
}
