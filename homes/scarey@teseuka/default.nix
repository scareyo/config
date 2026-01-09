{ pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/home/scarey";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];

  home.packages = with pkgs; [
    kubectl
    kubelogin-oidc
    lutris
    obsidian
    openscad
    osu-lazer-bin
    prismlauncher
    runelite
    vesktop
    vintagestory
    vlc
  ];

  scarey.home = {
    auto-upgrade = {
      enable = true;
      flake = "github:scareyo/config";
      dates = "07:30 UTC";
    };

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
        "com.mitchellh.ghostty.desktop"
        "vesktop.desktop"
        "steam.desktop"
      ];
    };

    firefox.enable = true;
    fonts.enable = true;
    ghostty.enable = true;
    gpg.enable = true;
    gpg.ssh.enable = true;
    kitty.enable = true;
    librewolf.enable = true;

    nvim = {
      enable = true;
      neovide.enable = true;
    };

    zsh.enable = true;
  };

  programs.mangohud.enable = true;

  home.stateVersion = "24.05";
}
