{ inputs, lib, ... }:

{
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Standalone Home Manager configurations";
  };

  config.systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
}
