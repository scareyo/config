{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.git.enable = mkEnableOption "Enable git configuration";
    scarey.home.git.name = mkOption {
      type = types.str;
      description = "Git user.name config";
    };
    scarey.home.git.email = mkOption {
      type = types.str;
      description = "Git user.email config";
    };
    scarey.home.git.gpgPath = mkOption {
      type = types.nullOr types.str;
      description = "Git signing.gpgPath config";
      default = null;
    };
  };

  config = lib.mkIf config.scarey.home.git.enable {
    programs.git = {
      enable = true;
      signing = {
        key = null;
        signByDefault = true;
        gpgPath = lib.mkIf (config.scarey.home.git.gpgPath != null) config.scarey.home.git.gpgPath;
      };
      settings = {
        user.name = config.scarey.home.git.name;
        user.email = config.scarey.home.git.email;
        diff.tool = "nvimdiff";
      };
    };
  };
}
