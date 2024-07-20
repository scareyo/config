{ lib, pkgs, ... }:

let
  secrets = lib.importJSON ./secrets.json;
in {
  imports = [
    ../../modules
  ];

  home.username = secrets.username;
  home.homeDirectory = "/Users/${secrets.username}";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    jetbrains.rider
  ];

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = secrets.email;
    };

    firefox.enable = true;
    fonts.enable = true;
    gpg.enable = true;
    kitty.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
