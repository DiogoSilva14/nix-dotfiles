{
	programs.zsh = {
		shellAliases = {
			"1" = "ssh paissilva@builder3";
			"2" = "ssh dps@projectpc";
			"3" = "ssh labgrid@projectpc";
			"ph" = "cd $PROJECTPC_HOME";
			"bd" = "cd $BUILDER3_DATA";
			"yocto" = "cd $YOCTO_SOURCES";
			"devtool_home" = "cd $DEVTOOL_SOURCES";
			"remount_sshfs" = "systemctl --user restart home-paissilva-mounts-builder3_data.mount && systemctl --user restart home-paissilva-mounts-projectpc_home.mount";
		};

		initExtra = ''
			export PROJECTPC_HOME=/home/paissilva/mounts/projectpc_home
			export BUILDER3_DATA=/home/paissilva/mounts/builder3_data
			export FUSION_HOME=$BUILDER3_DATA/fusion
			export YOCTO_HOME=$FUSION_HOME/yocto-fusion_scarthgap
			export YOCTO_SOURCES=$YOCTO_HOME/sources
			export DEVTOOL_SOURCES=$YOCTO_HOME/build/workspace/sources
			
			echo "==========================="
			echo
			fortune | cowsay
			echo
			echo "==========================="
			echo " [1] - paissilva@builder3"
			echo " [2] - dps@projectpc"
			echo " [3] - labgrid@projectpc"
			echo "==========================="
			echo
		'';
	};
}
