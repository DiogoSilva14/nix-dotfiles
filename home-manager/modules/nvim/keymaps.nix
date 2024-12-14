{
	programs.nixvim.globals.mapleader = " ";

	programs.nixvim.keymaps = [
		# Project View
		{
			mode = "n";
			key = "<leader>pv";
			action = "<cmd>Explore<cr>";
		}
		# Move selection down one line 
		{
			mode = "v";
			key = "J";
			action = ":m '>+1<CR>gv=gv";
		}
		# Move selection up one line
		{
			mode = "v";
			key = "K";
			action = ":m '<-2<CR>gv=gv";
		}
	];

}
