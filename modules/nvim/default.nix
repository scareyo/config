{ config, lib, pkgs, ... }:

let
  just-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "just.nvim";
    version = "2024-08-31";
    src = pkgs.fetchFromGitHub {
      owner = "al1-ce";
      repo = "just.nvim";
      rev = "664930c4791d92a88b8792e1e32a42275bef3fa4";
      sha256 = "189s0vfrw39f2c3h9vj3wsh9102ay49blh7hm7v617f50dzja057";
    };
  };
in
{
  options = with lib; {
    scarey.home.nvim.enable = mkEnableOption "Enable neovim configuration";
  };
  
  config = lib.mkIf config.scarey.home.nvim.enable {
    home.packages = with pkgs; [
      lazygit
      ripgrep
      unzip

      # LSPs
      gopls
      lua-language-server
      nil
      omnisharp-roslyn
      rust-analyzer
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
          plugin = feline-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/feline.lua;
        }
        {
          plugin = just-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/just.lua;
        }
        {
          plugin = mini-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugins/mini.lua;
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./config/plugins/lspconfig.lua;
        }
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = builtins.readFile ./config/plugins/nvim-tree.lua;
        }

        coq-artifacts
        fidget-nvim
        lazygit-nvim
        nvim-notify
        plenary-nvim
        telescope-nvim
      ];
    };
  };
}
