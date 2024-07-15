{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.nvim.enable = mkEnableOption "Enable neovim configuration";
  };
  
  config = lib.mkIf config.scarey.home.nvim.enable {
    home.packages = with pkgs; [
      ripgrep
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    xdg.configFile.nvim = {  
      source = ./config;  
      recursive = true;  
    };
  };
}
