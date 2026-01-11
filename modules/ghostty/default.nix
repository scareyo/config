{ config, inputs, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.ghostty.enable = mkEnableOption "Enable ghostty configuration";
  };
  
  config = lib.mkIf config.scarey.home.ghostty.enable {
    home.packages = [
      inputs.ghostty.packages.${pkgs.stdenv.system}.default
    ];

    xdg.configFile."ghostty/config.ghostty" = {
      text = ''
        theme = TokyoNight
        font-family = "Lilex Nerd Font"
      '';
    };
  };
}
