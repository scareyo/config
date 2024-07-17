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
  };

  config = lib.mkIf config.scarey.home.git.enable {
    programs.git = {
      enable = true;
      userName = config.scarey.home.git.name;
      userEmail = config.scarey.home.git.email;
      signing = {
        key = null;
        signByDefault = true;
      };
      extraConfig = {
        diff.tool = "nvimdiff";
      };
    };
  
    programs.gpg.enable = true;
  
    services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      enableZshIntegration = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      
      enableSshSupport = true;
      sshKeys = [
        "0A8EDEDE4953CE42F616879F6D86F997E9C181AC"
      ];
    };
  };
}
