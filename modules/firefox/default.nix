{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.firefox.enable = mkEnableOption "Enable firefox configuration";
  };
  
  config = lib.mkIf config.scarey.home.firefox.enable {
    programs.firefox = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin null;
      profiles.scarey = {
        isDefault = true;
        bookmarks = {};
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };
}
