{ pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/home/scarey";

  targets.genericLinux.enable = true;
    
  home.packages = with pkgs; [
    nixgl.nixGLIntel
  ];
      
  programs.zsh.shellAliases = {
    kitty = "nixGLIntel kitty";
  };

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = "sam@scarey.me";
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
