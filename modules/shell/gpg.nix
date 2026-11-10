{
  flake.modules.homeManager.gpg = { config, lib, pkgs, ... }:
    let
      scareyGpg = pkgs.fetchurl {
        url = "https://github.com/scareyo.gpg";
        hash = "sha256-uT+IS0fh4DCFdhWZq+2UFtkkhwYpvCS6b6cTIbxp2Ng=";
      };
    in
    {
      programs.gpg = {
        enable = true;
        publicKeys = [
          {
            source = "${scareyGpg}";
            trust = "ultimate";
          }
        ];
      };

      programs.zsh.initContent = lib.mkIf config.programs.zsh.enable ''
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
      '';

      services.gpg-agent = {
        enable = true;
        enableZshIntegration = true;
        pinentry.package = lib.mkDefault (
          if pkgs.stdenv.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3
        );

        enableSshSupport = true;
        sshKeys = lib.mkDefault [ "0A8EDEDE4953CE42F616879F6D86F997E9C181AC" ];
      };
    };
}
