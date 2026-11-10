{ config, inputs, ... }:

{
  flake.homeConfigurations."scarey@teseuka" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    modules = with config.flake.modules.homeManager; [
      config.flake.modules.homeManager."scarey@teseuka"
      base
      auto-upgrade
      brave
      firefox
      fonts
      ghostty
      git
      gnome
      gpg
      nvim
      zsh
    ];
  };

  flake.modules.homeManager."scarey@teseuka" = { pkgs, ... }: {
    home.username = "scarey";
    home.homeDirectory = "/home/scarey";

    home.packages = with pkgs; [
      claude-code
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

    scarey.home.auto-upgrade = {
      flake = "github:scareyo/config";
      dates = "07:30 UTC";
    };

    dconf.settings."org/gnome/shell".favorite-apps = [
      "org.gnome.Nautilus.desktop"
      "firefox.desktop"
      "com.mitchellh.ghostty.desktop"
      "dev.vencord.Vesktop.desktop"
      "steam.desktop"
    ];

    programs.mangohud.enable = true;

    home.stateVersion = "24.05";
  };
}
