{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./firefox
    ./fonts
    ./git
    ./ghostty
    ./gnome
    ./gpg
    ./kitty
    ./nvim
    ./zed
    ./zsh
  ];

  config = {
    programs.home-manager.enable = true;
 
    nixpkgs = {
      overlays = [
        inputs.nur.overlays.default
        (final: prev: import ../pkgs final.pkgs)
      ];
    };

    home.packages = with pkgs; [
      fastfetch
      just
      nix-search-cli
    ];
  };
}
