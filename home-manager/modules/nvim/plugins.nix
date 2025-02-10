{ pkgs, ... }:
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

		# Harpoon
		harpoon.enable = true;
		harpoon.enableTelescope = true;
		harpoon.keymaps = {
			addFile = "<leader>ha";
			toggleQuickMenu = "<C-h>";
			navFile = {
				"1" = "<leader>1";
				"2" = "<leader>2";
				"3" = "<leader>3";
				"4" = "<leader>4";
				"5" = "<leader>5";
				"6" = "<leader>6";
				"7" = "<leader>7";
				"8" = "<leader>8";
				"9" = "<leader>9";
			};
		};

		# Markdown render
		render-markdown.enable = true;

		# LSP
		lsp-format.enable = true;
		lsp.enable = true;
		lsp.inlayHints = true;
		lsp.servers = {
			rust_analyzer = {
				enable = true;
				installCargo = true;
				installRustc = true;
				installRustfmt = true;
			};
		};
	};
}
