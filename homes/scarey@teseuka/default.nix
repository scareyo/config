{ pkgs, ... }:

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

    (vesktop.overrideAttrs (finalAttrs: previousAttrs: {
      src = fetchFromGitHub {
        owner = "scareyo";
        repo = "vesktop";
        rev = "v1.6.5";
        hash = "sha256-Og3Xoeugxcn1k1D370KZIx3l6Ui05SrDL0oSnyDwun8=";
      };
      pnpmDeps = fetchPnpmDeps {
        inherit (finalAttrs) pname version src patches;
        pnpm = pnpm_10;
        fetcherVersion = 2;
        hash = "sha256-C3mM3cluLB8bB8sRFQjF3NDjgZ+R9HcNRCdLNqT0ujk=";
      };
      buildInputs = previousAttrs.buildInputs ++ [
        libx11.dev
        libxcb.dev
        libxkbcommon.dev
        libxtst
      ];
      desktopItems = lib.optional stdenv.hostPlatform.isLinux (makeDesktopItem {
        name = "dev.vencord.Vesktop";
        desktopName = "Vesktop";
        exec = "vesktop %U";
        icon = "vesktop";
        startupWMClass = "vesktop";
        genericName = "Internet Messenger";
        startupNotify = false;
        keywords = [
          "discord"
          "vencord"
          "electron"
          "chat"
        ];
        categories = [
          "Network"
          "InstantMessaging"
          "Chat"
        ];
      });
    }))
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

    firefox.enable = true;
    fonts.enable = true;
    ghostty.enable = true;
    gpg.enable = true;
    gpg.ssh.enable = true;
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
