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
    openscad
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

    gpg = {
      enable = true;
      ssh = {
        enable = true;
        pinentry = pkgs.pinentry_mac;
      };
    };

    firefox.enable = true;
    fonts.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
