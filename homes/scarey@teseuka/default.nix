{ pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/home/scarey";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    alvr
    lutris
    obsidian
    openmw
    vesktop
  ];

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = "sam@scarey.me";
    };

    gnome = {
      enable = true;
      pinned = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "vesktop.desktop"
        "steam.desktop"
      ];
    };

    firefox.enable = true;
    fonts.enable = true;
    gpg.enable = true;
    kitty.enable = true;

    nvim = {
      enable = true;
      neovide.enable = true;
    };

    zsh.enable = true;
  };

  programs.mangohud.enable = true;

  home.stateVersion = "24.05";
}
