{ lib, pkgs, ... }:

let
  secrets = lib.importJSON ./secrets.json;
in {
  imports = [
    ../../modules
  ];
  
  # FIXME: https://nixpk.gs/pr-tracker.html?pr=338033
  #nixpkgs.config.packageOverrides = pkgs: {
  #  kitty = pkgs.kitty.overrideAttrs (old: {
  #    preBuild = ''
  #      # Add the font by hand because fontconfig does not finds it in darwin
  #      mkdir ./fonts/
  #      cp "${(pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})}/share/fonts/truetype/NerdFonts/SymbolsNerdFontMono-Regular.ttf" ./fonts/
  #    '';
  #  });
  #};

  home.username = secrets.username;
  home.homeDirectory = "/Users/${secrets.username}";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    awscli2
    jetbrains.rider
    localstack
    powershell
    rectangle
    vscode
    
    (with dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0_3xx
      sdk_8_0
    ])
  ];

  programs.zsh.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}";
  };

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
