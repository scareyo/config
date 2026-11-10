[
  ##############################################################################
  # Tabs
  ##############################################################################
  { key = "<LEFT>";           action = "<cmd>BufferLineCyclePrev<CR>"; }
  { key = "<RIGHT>";          action = "<cmd>BufferLineCycleNext<CR>"; }
  { key = "<leader><LEFT>";   action = "<cmd>BufferLineMovePrev<CR>"; }
  { key = "<leader><RIGHT>";  action = "<cmd>BufferLineMoveNext<CR>"; }
  { key = "<leader>q";        action = "<cmd>TabClose<CR>"; }

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
  { key = "<leader>g"; action = "<cmd>LazyGit<CR>"; }

  ##############################################################################
  # LSP
  ##############################################################################
  { key = "<leader>r"; action = "<cmd>Telescope lsp_references<CR>"; }
  { key = "<leader>d"; action = "<cmd>Telescope lsp_definitions<CR>"; }
  { key = "<leader>i"; action = "<cmd>Telescope lsp_implementations<CR>"; }
  {
    key = "<leader><leader>";
    action.__raw = ''
      function()
        vim.lsp.buf.hover()
      end
    '';
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
  { key = "<leader>t"; action = "<cmd>Telescope<CR>"; }
  { key = "<leader>f"; action = "<cmd>Telescope live_grep<CR>"; }

  ##############################################################################
  # Terminal
  ##############################################################################
  { mode = "t"; key = "<F1>"; action = "<C-\\><C-n>"; }
]
