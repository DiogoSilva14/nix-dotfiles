{
	programs.zsh = {
		shellAliases = {
			"1" = "ssh paissilva@builder3";
			"2" = "ssh dps@projectpc";
			"3" = "ssh labgrid@projectpc";
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
