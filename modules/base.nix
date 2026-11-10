{ inputs, ... }:

{
  flake.modules.homeManager.base = { pkgs, ... }: {
    programs.home-manager.enable = true;

    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        inputs.nur.overlays.default
      ];
    };

    home.packages = with pkgs; [
      fastfetch
      just
      nix-search-cli
    ];
  };
}
