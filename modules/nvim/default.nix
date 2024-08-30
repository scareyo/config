{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.nvim.enable = mkEnableOption "Enable neovim configuration";
  };
  
  config = lib.mkIf config.scarey.home.nvim.enable {
    home.packages = with pkgs; [
      ripgrep
      unzip
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = builtins.readFile ./config/nvim.lua;

      plugins = with pkgs.vimPlugins; [
        {
          plugin = bufferline-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/bufferline.lua;
        }
        {
          plugin = catppuccin-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/catppuccin.lua;
        }
        {
          plugin = coq_nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/coq.lua;
        }
        {
          plugin = dashboard-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/dashboard.lua;
        }
        {
          plugin = feline-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/feline.lua;
        }
        {
          plugin = mason-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/mason.lua;
        }
        {
          plugin = mason-lspconfig-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/mason-lspconfig.lua;
        }
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = builtins.readFile ./config/plugins/nvim-tree.lua;
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/telescope.lua;
        }
      ];
    };
  };
}
