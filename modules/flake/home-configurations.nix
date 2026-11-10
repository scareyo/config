{ lib, ... }:

{
  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Standalone Home Manager configurations";
  };
}
