{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./firefox
    ./fonts
    ./git
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
        inputs.nur.overlay
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
