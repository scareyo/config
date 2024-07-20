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
      type = types.str;
      description = "Git signing.gpgPath config";
      default = null;
    };
  };

  config = lib.mkIf config.scarey.home.git.enable {
    programs.git = {
      enable = true;
      userName = config.scarey.home.git.name;
      userEmail = config.scarey.home.git.email;
      signing = {
        key = null;
        signByDefault = true;
        gpgPath = config.scarey.home.git.gpgPath;
      };
      extraConfig = {
        diff.tool = "nvimdiff";
      };
    };
  };
}
