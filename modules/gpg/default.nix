{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.gpg.enable = mkEnableOption "Enable GnuPG configuration";
  };

  config = lib.mkIf config.scarey.home.gpg.enable {
    programs.gpg.enable = true;
    programs.gpg.scdaemonSettings = {
      disable-ccid = true;
    };
  
    services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      enableZshIntegration = true;
      pinentryPackage = pkgs.pinentry-tty;
      
      enableSshSupport = true;
      sshKeys = [
        "0A8EDEDE4953CE42F616879F6D86F997E9C181AC"
      ];
    };
  };
}

