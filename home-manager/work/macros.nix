{
	programs.zsh = {
		shellAliases = {
			"1" = "ssh paissilva@builder3";
			"2" = "ssh dps@projectpc";
			"3" = "ssh labgrid@projectpc";
			"ph" = "cd $PH";
			"bd" = "cd $BD";
		};

		sessionVariables = {
			"PH" = "/home/paissilva/mounts/projectpc_home";
			"BD" = "/home/paissilva/mounts/builder3_data";
		};

		initExtra = ''
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
