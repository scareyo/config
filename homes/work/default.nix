{ lib, ... }:

let
  secrets = lib.importJSON ./secrets.json;
in {
  imports = [
    ../../modules
  ];

  home.username = secrets.username;
  home.homeDirectory = "/Users/${secrets.username}";

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = secrets.email;
    };

    firefox.enable = true;
    fonts.enable = true;
    kitty.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
