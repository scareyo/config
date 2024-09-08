{ config, lib, pkgs, ... }:

let
  cfg = config.scarey.home.zed;
  jsonFormat = pkgs.formats.json {};
in
{
  options = with lib; {
    scarey.home.zed.enable = mkEnableOption "Enable zed configuration";
    scarey.home.zed.settings = mkOption {
      type = jsonFormat.type;
      default = {
        vim_mode = true;
        base_keymap = "JetBrains";
        ui_font_size = 18;
        buffer_font_size = 18;
        theme = {
          mode = "dark";
          light = "One Light";
          dark = "Rosé Pine";
        };
        tab_size = 2;
        ensure_final_newline_on_save = false;
      };
    };
  };

  config = lib.mkIf config.scarey.home.zed.enable {
    home.packages = with pkgs; [
      zed-editor
    ];
    xdg.configFile = {
      "zed/settings.json".text = builtins.toJSON cfg.settings;
    };
  };
}
