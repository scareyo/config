{
  flake.modules.homeManager.neovide = { pkgs, ... }:
    let
      tomlFormat = pkgs.formats.toml {};
    in
    {
      home.packages = with pkgs; [
        neovide
      ];

      xdg.configFile."neovide/config.toml" = {
        source = tomlFormat.generate "neovide-config" {
          fork = true;
          font.normal = [ "MesloLGS Nerd Font" ];
          font.size = 12;
          maximized = false;
          tabs = false;
        };
      };

      programs.nixvim.globals = {
        neovide_transparency = 0.95;
      };
    };
}
