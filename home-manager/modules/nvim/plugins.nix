{
	programs.nixvim.plugins = {
		# Telescope needs this one
		web-devicons.enable = true;

		# Telescope
		telescope.enable = true;
		telescope.keymaps = {
			"<leader>pf" = {
				action = "find_files";
				options.desc = "Open files";
			};
			"<leader>gs" = {
				action = "git_status";
				options.desc = "Status";
			};
			"<leader>gc" = {
				action = "git_commits";
				options.desc = "Commits";
			};
			"<leader>fg" = {
				action = "live_grep";
				options.desc = "Grep";
			};
		};
	};
}
