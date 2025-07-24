{
  systemd.user = {
    mounts = {
      home-paissilva-mounts-builder3_data = {
        Unit = {
          Description = "Mount builder data";
        };
        Mount = {
          What="paissilva@builder3:/data/paissilva";
          Where="/home/paissilva/mounts/builder3_data";
          Type="sshfs";
          Options="x-systemd.automount,reconnect";
        };
      };
      home-paissilva-mounts-projectpc_home = {
        Unit = {
          Description = "Mount ProjectPc home";
        };
        Mount = {
          What="dps@projectpc:/home/dps";
          Where="/home/paissilva/mounts/projectpc_home";
          Type="sshfs";
          Options="x-systemd.automount,reconnect";
        };
      };
    };
  };
}
