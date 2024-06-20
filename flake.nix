{
  description = "A scarey home configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    homeConfigurations."scarey@teseuka" = home-manager.lib.homeManagerConfiguration {
      modules = [ (./. + "/homes/scarey@teseuka") ];
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    };

    homeModules = {
      default = import ./modules;
    };
  };
}
