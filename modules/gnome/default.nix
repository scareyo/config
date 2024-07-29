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
      gnome-tweaks
    ];

    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
      };
      "org/gnome/shell" = lib.mkIf ((builtins.length config.scarey.home.gnome.pinned) > 0) {
        favorite-apps = config.scarey.home.gnome.pinned;
      };
    };
  };
}
