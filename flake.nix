{
  description = "A scarey home configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-parts, nixvim, nur }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        homeConfigurations = {
          "scarey@teseuka" = home-manager.lib.homeManagerConfiguration {
            modules = [ (./. + "/homes/scarey@teseuka") ];
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; };
          };
          "scarey@vegapunk" = home-manager.lib.homeManagerConfiguration {
            modules = [ (./. + "/homes/scarey@vegapunk") ];
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs; };
          };
          "work" = home-manager.lib.homeManagerConfiguration {
            modules = [ (./. + "/homes/work") ];
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs; };
          };
        };
        nixosConfigurations."teseuka" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/teseuka ];
          specialArgs = { inherit self; };
        };
      };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = { config, pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git-crypt
            just
          ];
        };
      };
    };
}
