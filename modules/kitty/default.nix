{ config, lib, ... }:

{
  options = with lib; {
    scarey.home.kitty.enable = mkEnableOption "Enable kitty configuration";
  };
  
  config = lib.mkIf config.scarey.home.kitty.enable {
    programs.kitty = {
      enable = true;
    };

    xdg.configFile.kitty = {  
      source = ./config;  
      recursive = true;  
    };
  };
}
