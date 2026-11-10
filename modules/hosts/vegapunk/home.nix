{ config, ... }:

{
  configurations.home."scarey@vegapunk" = {
    system = "aarch64-darwin";
    modules = with config.flake.modules.homeManager; [
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
      claude-code
      yubikey-manager
    ];

    programs.zsh.sessionVariables = {
      PATH = "$PATH:/opt/homebrew/bin";
    };

    home.stateVersion = "24.05";
  };
}
