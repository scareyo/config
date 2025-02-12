{
  bufferline = {
    enable = true;
    settings = {
      options = {
        close_command = "TabClose";
        offsets = [
          {
            filetype = "NvimTree";
            text = "File Explorer";
            highlight = "Directory";
            separator = true;
          }
        ];
        hover = {
          enabled = true;
          delay = 0;
          reveal = [ "close" ];
        };
      };
    };
  };

  cmp = {
    enable = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      mapping = {
        "<Esc>" = "cmp.mapping.close()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };

  lazygit.enable = true;

  lsp = {
    enable = true;
    servers = {
      ccls.enable = true;
      gopls.enable = true;
      lua_ls = {
        enable = true;
        settings.diagnostics.globals = [
          "vim"
        ];
      };
      nil_ls.enable = true;
      omnisharp.enable = true;
      rust_analyzer = {
        enable = true;
        installRustc = true;
        installCargo = true;
      };
    };
  };

  lualine = {
    enable = true;
    settings.options.ignore_focus = [
      "NvimTree"
    ];
  };

  mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      icons = {};
      sessions = {
        autoread = true;
        hooks.post.read.__raw = ''
          function()
            vim.api.nvim_command("NvimTreeOpen")
            vim.cmd "wincmd p"
          end
        '';
      };
    };
  };

  nvim-tree = {
    enable = true;
    git = {
      ignore = false;
    };
    updateFocusedFile.enable = true;
    view.width = 40;
  };

  telescope.enable = true;
}
