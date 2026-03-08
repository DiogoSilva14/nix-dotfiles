{ config, pkgs, lib, ... }:
{
  services.openssh.enable = true;

  services.nextcloud = {
    enable = true;
    hostName = "tioserver";
    config.dbtype = "sqlite";
    datadir = "/data/nextcloud";
    config.adminpassFile = "/data/nextcloud/admin-pwd";

    phpOptions."upload_max_filesize" = lib.mkForce "40G";
    phpOptions."post_max_size" = lib.mkForce "40G";
    phpOptions."memory_limit" = "512M";
    phpOptions."max_execution_time" = "3600";
    phpOptions."max_input_time" = "3600";
  };

  services.couchdb = {
    enable = true;
    configFile = "/data/couchdb/local.ini";
    logFile = "/data/couchdb/couchdb.log";
    databaseDir = "/data/couchdb";
  };

  services.home-assistant = {
    enable = true;
    configDir = "/data/home-assistant";
    config = {
      default_config = {};
    };
    extraComponents = [
      "default_config"
      "systemmonitor"
      "esphome"
      "mqtt"
    ];
    extraPackages = python3Packages: with python3Packages; [
       glances-api
    ];
  };

  systemd.services.glances = {
    description = "Glances system monitor";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
       ExecStart = "${pkgs.glances}/bin/glances -w";
       Restart = "always";
    };
  };

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      homeassistant.enabled = config.services.home-assistant.enable;
      permit_join = true;
      serial = {
        port = "/dev/zigbee_adapter";
        adapter = "zstack";
      };
      frontend.enabled = true;
      mqtt = {
        server = "mqtt://127.0.0.1:1883";
      };
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [{
      address = "127.0.0.1";
      port = 1883;
      acl = [ "pattern readwrite #" ];
      omitPasswordAuth = true;
      settings.allow_anonymous = true;
    }];
  };
}
