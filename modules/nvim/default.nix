{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./plugins/just.nix
  ];

  options = with lib; {
    scarey.home.nvim.enable = mkEnableOption "Enable neovim configuration";
  };
  
  config = lib.mkIf config.scarey.home.nvim.enable {
    home.packages = with pkgs; [
      ripgrep
    ];

    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;

      autoCmd = import ./autocmds.nix;
      keymaps = import ./keymaps.nix;
      opts = import ./options.nix;
      plugins = import ./plugins.nix;

      diagnostics = {
        virtual_text = false;
      };

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
