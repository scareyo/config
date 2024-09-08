[
  ##############################################################################
  # Navigation
  ##############################################################################
  {
    key = "<LEFT>";
    action = "<cmd>BufferLineCyclePrev<CR>";
  }
  {
    key = "<RIGHT>";
    action = "<cmd>BufferLineCycleNext<CR>";
  }
  {
    key = "<leader><LEFT>";
    action = "<cmd>BufferLineMovePrev<CR>";
  }
  {
    key = "<leader><RIGHT>";
    action = "<cmd>BufferLineMoveNext<CR>";
  }

  ##############################################################################
  # Close file
  ##############################################################################
  {
    key = "<leader>q";
    action = "<cmd>TabClose<CR>";
  }

  ##############################################################################
  # Just
  ##############################################################################
  {
    key = "<leader>j";
    action = "<cmd>JustSelect<CR>";
  }

  ##############################################################################
  # LazyGit
  ##############################################################################
  {
    key = "<leader>g";
    action = "<cmd>LazyGit<CR>";
  }

  ##############################################################################
  # NvimTree
  ##############################################################################
  {
    key = "<leader><TAB>";
    action.__raw = ''
      function()
        vim.api.nvim_command("NvimTreeToggle")
        vim.cmd "wincmd p"
      end
    '';
  }
  {
    key = "<leader>h";
    action.__raw = ''
      function()
        require("nvim-tree.api").tree.toggle_gitignore_filter()
      end
    '';
  }

  ##############################################################################
  # Telescope
  ##############################################################################
  {
    key = "<leader>t";
    action = "<cmd>Telescope<CR>";
  }
  {
    key = "<leader>f";
    action = "<cmd>Telescope live_grep<CR>";
  }
]
