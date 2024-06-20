{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/home/scarey";

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = "sam@scarey.me";
    };

    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
