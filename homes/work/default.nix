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
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
  ];

  home.packages = with pkgs; [
    awscli2
    jetbrains.rider
    localstack
    postman
    powershell
    rectangle
    vscode
    
    (with dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_8_0
    ])
  ];

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = secrets.email;
    };

    gpg = {
      enable = true;
      ssh = {
        enable = true;
        pinentry = pkgs.pinentry_mac;
        keys = [ "DDE0EEB6DE49F3E9405A1A7645DC79E77A2B9645" ];
      };
    };

    firefox.enable = true;
    fonts.enable = true;
    kitty.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
