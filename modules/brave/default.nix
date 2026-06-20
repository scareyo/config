{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.brave.enable = mkEnableOption "Enable Brave configuration";
  };

  config = lib.mkIf config.scarey.home.brave.enable {

    launchd.agents."me.scarey.config" = {
      enable = true;
      config = {
        ProgramArguments = [ "launchctl" "setenv" "MOZ_LEGACY_PROFILES" "1" ];
      };
    };

    programs.chromium = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then null else pkgs.brave;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      ];
    };
  };
}
