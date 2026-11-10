{ inputs, ... }:

{
  flake.modules.homeManager.ghostty = { lib, pkgs, ... }: {
    home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
      inputs.ghostty.packages.${pkgs.stdenv.system}.default
    ];

    xdg.configFile."ghostty/config.ghostty" = {
      text = ''
        theme = TokyoNight
        font-family = "Lilex Nerd Font"
      '';
    };
  };
}
