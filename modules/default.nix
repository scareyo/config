{ pkgs, ... }:

{
  imports = [
    ./firefox
    ./git
    ./kitty
    ./nvim
    ./zsh
  ];

  config = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      fastfetch
      just
    ];
  };
}
