{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.firefox.enable = mkEnableOption "Enable firefox configuration";
  };
  
  config = lib.mkIf config.scarey.home.firefox.enable {

    launchd.agents."me.scarey.config" = {
      enable = true;
      config = {
        ProgramArguments = [ "launchctl" "setenv" "MOZ_LEGACY_PROFILES" "1" ];
      };
    };

    programs.firefox = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin null;
      profiles.scarey = {
        isDefault = true;
        bookmarks = {};
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          multi-account-containers
          ublock-origin
        ];
      };
    };
  };
}
