{
	systemd.user = {
		mounts = {
			mount-test = {
				Unit = {
					Description = "mount test home";
				};
				Mount = {
					What="paissilva@builder3:~/";
					Where="~/mounts/builder3-home";
					Type="sshfs";
					Options="x-systemd.automount,_netdev,reconnect,allow_other,identityfile=~/.ssh/id_rsa";
				};
			};
		};
	};
}
