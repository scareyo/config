{ config, lib, pkgs, ... }:

let
  cfg = config.scarey.home;

  scareyGpg = pkgs.fetchurl {
    url = "https://scarey.me/scarey.gpg";
    sha256 = "1waqh8slipq31vfxzg2lawbbrxqnzdiyrz6hrg137i6nlvn48925";
  };
in
{
  options = with lib; {
    scarey.home.gpg.enable = mkEnableOption "Enable GnuPG configuration";
    scarey.home.gpg.ssh.enable = mkEnableOption "Enable GnuPG SSH authentication";
  };

  config = lib.mkIf cfg.gpg.enable {
    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = "${scareyGpg}";
          trust = "ultimate";
        }
      ];
    };

    programs.zsh.initExtra = lib.mkIf (cfg.gpg.ssh.enable && cfg.zsh.enable) ''
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

