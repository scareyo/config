{
  bufferline = {
    enable = true;
    settings = {
      options = {
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
      omnisharp.enable = true;
      gopls.enable = true;
      lua-ls = {
        enable = true;
        settings.diagnostics.globals = [
          "vim"
        ];
      };
      nil-ls.enable = true;
      rust-analyzer = {
        enable = true;
        installRustc = true;
        installCargo = true;
      };
    };
  };

  lualine = {
    enable = true;
    ignoreFocus = [
      "NvimTree"
    ];
  };

  mini = {
    enable = true;
    modules = {
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
