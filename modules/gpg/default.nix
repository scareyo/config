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
    scarey.home.gpg.ssh.pinentry = mkOption {
        type = types.package;
        example = literalExpression "pkgs.pinentry-gnome3";
        default = pkgs.pinentry-gnome3;
        description = "Pin entry package to use";
    };
    scarey.home.gpg.ssh.keys = mkOption {
      type = types.listOf types.str;
      default = [ "0A8EDEDE4953CE42F616879F6D86F997E9C181AC" ];
      description = "List of SSH keys to add to gpg-agent";
    };
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

    programs.zsh.initContent = lib.mkIf (cfg.gpg.ssh.enable && cfg.zsh.enable) ''
      export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    '';

    services.gpg-agent = {
      enable = true;
      enableZshIntegration = true;
      pinentry.package = cfg.gpg.ssh.pinentry;
      
      enableSshSupport = true;
      sshKeys = cfg.gpg.ssh.keys;
    };
  };
}

