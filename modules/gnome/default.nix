{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.gnome.enable = mkEnableOption "Enable GNOME configuration";
    scarey.home.gnome.pinned = mkOption {
      type = types.listOf types.str;
      description = "Applications to pin to dash";
      default = [];
    };
  };
  
  config = lib.mkIf config.scarey.home.gnome.enable {
    home.packages = with pkgs; [
      firefox-gnome-theme
      gnome-tweaks
      rewaita
    ];
    
    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs; [
        { package = gnomeExtensions.dash-to-dock; }
        { package = gnomeExtensions.nothing-to-say; }
        { package = gnomeExtensions.user-themes; }
      ];
    };

    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [];
        switch-applications-backward = [];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
      };
      "org/gnome/shell" = lib.mkIf ((builtins.length config.scarey.home.gnome.pinned) > 0) {
        favorite-apps = config.scarey.home.gnome.pinned;
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "rewaita";
      };
    };
  };
}
