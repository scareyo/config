{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.fonts.enable = mkEnableOption "Enable fonts";
  };
  
  config = lib.mkIf config.scarey.home.fonts.enable {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };
}

