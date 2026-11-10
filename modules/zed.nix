{
  flake.modules.homeManager.zed = { pkgs, ... }:
    let
      settings = {
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
    in
    {
      home.packages = with pkgs; [
        zed-editor
      ];
      xdg.configFile = {
        "zed/settings.json".text = builtins.toJSON settings;
      };
    };
}
