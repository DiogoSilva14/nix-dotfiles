{  lib, config, pkgs, ... }: {
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

		globals.mapleader = " ";

		extraConfigLua = ''
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
