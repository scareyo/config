{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.auto-upgrade.enable = mkEnableOption "Whether to periodically upgrade Home Manager to the latest version";

    scarey.home.auto-upgrade.flake = mkOption {
      type = types.str;
      description = "The Flake URI of the Home Manager configuration to build";
    };

    scarey.home.auto-upgrade.host = mkOption {
      type = types.str;
      default = "";
      description = "The Home Manager configuration to use";
    };

    scarey.home.auto-upgrade.dates = mkOption {
      type = types.str;
      default = "05:00";
      description = "How often or when upgrade occurs";
    };
  };

  config = let
    cfg = config.scarey.home.auto-upgrade;
    autoUpgrade = pkgs.writeShellApplication {
      name = "hm-auto-upgrade";
      text = ''
        echo "Switching to latest flake: $AU_FLAKE"
        if [[ "$AU_HOST" == "" ]]; then
          home-manager switch --flake "$AU_FLAKE"
        else
          home-manager switch --flake "$AU_FLAKE#$AU_HOST"
        fi
      '';
      runtimeInputs = [
        pkgs.home-manager
        pkgs.nix
      ];
    };
  in lib.mkIf cfg.enable {

    assertions = [
      (lib.hm.assertions.assertPlatform "scarey.home.auto-upgrade" pkgs lib.platforms.linux)
    ];

    systemd.user = {
      timers.hm-auto-upgrade = {
        Unit.Description = "Home Manager upgrade timer";
        Install.WantedBy = [ "timers.target" ];
        Timer = {
          OnCalendar = cfg.dates;
          Unit = "hm-auto-upgrade.service";
          Persistent = true;
        };
      };
      services.hm-auto-upgrade = {
        Unit.Description = "Home Manager upgrade";
        Service = {
          ExecStart = "${autoUpgrade}/bin/hm-auto-upgrade";
          Environment = [
            "AU_FLAKE=${cfg.flake}"
            "AU_HOST=${cfg.host}"
          ];
        };
      };
    };
  };
}
