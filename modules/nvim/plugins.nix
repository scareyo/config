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

  coq-nvim = {
    enable = true;
    settings = {
      auto_start = true;
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
