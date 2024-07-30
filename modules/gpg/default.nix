{ config, lib, pkgs, ... }:

let
  scareyGpg = pkgs.fetchurl {
    url = "https://scarey.me/scarey.gpg";
    sha256 = "1waqh8slipq31vfxzg2lawbbrxqnzdiyrz6hrg137i6nlvn48925";
  };
in
{
  options = with lib; {
    scarey.home.gpg.enable = mkEnableOption "Enable GnuPG configuration";
  };

  config = lib.mkIf config.scarey.home.gpg.enable {
    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = "${scareyGpg}";
          trust = "ultimate";
        }
      ];
    };

    programs.zsh.initExtra = lib.mkIf config.scarey.home.zsh.enable ''
      export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    '';

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

