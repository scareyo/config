{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/Users/scarey";

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = "sam@scarey.me";
    };

    firefox.enable = true;
    gpg.enable = true;
    kitty.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
