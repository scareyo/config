{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./firefox
    ./fonts
    ./git
    ./gnome
    ./gpg
    ./kitty
    ./nvim
    ./zsh
  ];

  config = {
    programs.home-manager.enable = true;
 
    nixpkgs = {
      overlays = [
        inputs.nur.overlay
        (final: prev: import ../pkgs final.pkgs)
      ];
    };

    home.packages = with pkgs; [
      fastfetch
      just
      nix-search-cli
    ];

    home.activation = lib.mkIf pkgs.stdenv.isDarwin {
      rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
        apps_source="$genProfilePath/home-path/Applications"
        moniker="Nix Apps"
        app_target_base="${config.home.homeDirectory}/Applications"
        app_target="$app_target_base/$moniker"
        mkdir -p "$app_target"
        ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
      '';
    };
  };
}
