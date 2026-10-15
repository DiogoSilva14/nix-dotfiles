{
  virtualisation.oci-containers.containers = {
      couchdb = {
        image = "couchdb:3.5.1";

        autoStart = true;

        ports = [
          "127.0.0.1:5984:5984/tcp"
        ];

        volumes = [
          "/data/containers/couchdb/data:/opt/couchdb/data"
          "/data/containers/couchdb/local.ini:/opt/couchdb/etc/local.ini"
        ];
      };
  };
}
