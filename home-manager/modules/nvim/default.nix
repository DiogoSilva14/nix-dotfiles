{ lib, config, pkgs, ... }: {

	imports = [
		./keymaps.nix
		./plugins.nix
	];

	programs.nixvim = {
		enable = true;
		defaultEditor = true;

		viAlias = true;
		vimAlias = true;

		colorschemes.catppuccin.enable = true;
		plugins.lualine.enable = true;

		clipboard = {
			register = "unnamedplus";
			providers.wl-copy.enable = true;
		};

		# Highlight white characters
		extraConfigLua = ''
			vim.opt.nu = true

			vim.opt.undofile = true

			vim.opt.list = true
			vim.opt.listchars = {
				eol = "↓",
				tab = "  ┊",
				trail = "●",
				extends = "…",
				precedes = "…",
				space = "·"
			}
		'';
	};
}
