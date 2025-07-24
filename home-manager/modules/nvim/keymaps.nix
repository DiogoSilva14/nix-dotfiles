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
    # Harpoon
    {
      mode = "n";
      key = "<leader>ha";
      action.__raw = "function() require'harpoon':list():add() end";
    }
    {
      mode = "n";
      key = "<C-h>";
      action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
    }
    {
      mode = "n";
      key = "<leader>1";
      action.__raw = "function() require'harpoon':list():select(1) end";
    }
    {
      mode = "n";
      key = "<leader>2";
      action.__raw = "function() require'harpoon':list():select(2) end";
    }
    {
      mode = "n";
      key = "<leader>3";
      action.__raw = "function() require'harpoon':list():select(3) end";
    }
    {
      mode = "n";
      key = "<leader>4";
      action.__raw = "function() require'harpoon':list():select(4) end";
    }
    {
      mode = "n";
      key = "<leader>5";
      action.__raw = "function() require'harpoon':list():select(5) end";
    }
    {
      mode = "n";
      key = "<leader>6";
      action.__raw = "function() require'harpoon':list():select(6) end";
    }
    {
      mode = "n";
      key = "<leader>7";
      action.__raw = "function() require'harpoon':list():select(7) end";
    }
    {
      mode = "n";
      key = "<leader>8";
      action.__raw = "function() require'harpoon':list():select(8) end";
    }
    {
      mode = "n";
      key = "<leader>9";
      action.__raw = "function() require'harpoon':list():select(9) end";
    }
  ];

}
