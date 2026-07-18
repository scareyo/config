{ inputs, pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/home/scarey";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    kubectl
    kubelogin-oidc
    lutris
    obsidian
    openscad
    osu-lazer-bin
    prismlauncher
    runelite
    vintagestory
    vlc
    
    inputs.vesktop.packages.x86_64-linux.default
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
        "dev.vencord.Vesktop.desktop"
        "steam.desktop"
      ];
    };

    brave.enable = true;
    firefox.enable = true;
    fonts.enable = true;
    ghostty.enable = true;
    gpg.enable = true;
    gpg.ssh.enable = true;

    nvim = {
      enable = true;
      neovide.enable = true;
    };

    zsh.enable = true;
  };

  programs.mangohud.enable = true;

  home.stateVersion = "24.05";
}
