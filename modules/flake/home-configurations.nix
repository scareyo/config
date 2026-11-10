{
  config,
  inputs,
  lib,
  ...
}:

let
  hm = config.flake.modules.homeManager;
in
{
  options.configurations.home = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options = {
          system = lib.mkOption {
            type = lib.types.str;
            description = "The system to build the configuration for";
          };
          modules = lib.mkOption {
            type = lib.types.listOf lib.types.deferredModule;
            default = [ ];
            description = "Feature modules to import, in addition to the host's own module and base";
          };
        };
      }
    );
    default = { };
    description = "Standalone Home Manager configurations, each built from flake.modules.homeManager.<name>";
  };

  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Standalone Home Manager configurations";
  };

  config.flake.homeConfigurations = lib.mapAttrs (
    name: cfg:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${cfg.system};
      modules = [
        hm.${name}
        hm.base
      ]
      ++ cfg.modules;
    }
  ) config.configurations.home;
}
