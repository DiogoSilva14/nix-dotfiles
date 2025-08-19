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

    # Markdown render
    render-markdown.enable = true;

    # Markdown preview
    markdown-preview.enable = true;
    markdown-preview.settings.auto_start = 1;

    # LSP
    lsp-format.enable = true;
    lsp.enable = true;
    lsp.inlayHints = true;
    lsp.servers = {
      clangd.enable = true;
      cmake.enable = true;
      marksman.enable = true;
      nixd.enable = true;
      slint_lsp.enable = true;
      bashls.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
        installRustfmt = true;
      };
      pylsp = {
        enable = true;
        settings = {
          plugins = {
            ruff.enabled = true;
          };
        };
      };
    };

    # Complete
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };
    };
  };
}
