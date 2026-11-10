{
  flake.modules.homeManager.fonts = { pkgs, ... }: {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      adwaita-fonts
      nerd-fonts.lilex
    ];
  };
}
