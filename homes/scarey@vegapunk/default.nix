{ pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/Users/scarey";

  nixpkgs.config.allowUnfree = true;
    
  home.packages = with pkgs; [
    discord
    yubikey-manager
  ];
      
  programs.zsh.sessionVariables = {
    PATH = "$PATH:/opt/homebrew/bin";
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
