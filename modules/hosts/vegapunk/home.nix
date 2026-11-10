{ config, inputs, ... }:

{
  flake.homeConfigurations."scarey@vegapunk" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
    modules = with config.flake.modules.homeManager; [
      config.flake.modules.homeManager."scarey@vegapunk"
      base
      firefox
      fonts
      ghostty
      git
      gpg
      nvim
      zsh
    ];
  };

  flake.modules.homeManager."scarey@vegapunk" = { pkgs, ... }: {
    home.username = "scarey";
    home.homeDirectory = "/Users/scarey";

    home.packages = with pkgs; [
      yubikey-manager
    ];

    programs.zsh.sessionVariables = {
      PATH = "$PATH:/opt/homebrew/bin";
    };

    home.stateVersion = "24.05";
  };
}
