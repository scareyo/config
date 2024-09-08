{ config, inputs, lib, pkgs, ... }:

let
  cfg = config.scarey.home.nvim;
  tomlFormat = pkgs.formats.toml{};
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./plugins/just.nix
  ];

  options = with lib; {
    scarey.home.nvim.enable = mkEnableOption "Enable neovim configuration";
    scarey.home.nvim.neovide.enable = mkEnableOption "Enable neovide";
    scarey.home.nvim.neovide.settings = mkOption {
      type = tomlFormat.type;
      default = {
        fork = true;
        font.normal = [ "MesloLGS Nerd Font" ];
        font.size = 12;
        maximized = false;
        tabs = false;
      };
    };
  };
  
  config = lib.mkIf config.scarey.home.nvim.enable {
    home.packages = with pkgs; [
      ripgrep

      (lib.mkIf cfg.neovide.enable neovide)
    ];

    xdg.configFile."neovide/config.toml" = {
      source = tomlFormat.generate "neovide-config" cfg.neovide.settings;
    };

    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;

      autoCmd = import ./autocmds.nix;
      keymaps = import ./keymaps.nix;
      opts = import ./options.nix;
      plugins = import ./plugins.nix;

      userCommands = {
        TabClose = {
          command.__raw = ''
            function()
              if (vim.bo.modified) then
                print("There are unsaved changes")
                return
              end

              local target_buffer = vim.api.nvim_get_current_buf()
              vim.api.nvim_command('bprev')
              vim.api.nvim_command('bd! ' .. target_buffer)
            end
          '';
        };
      };

      globals = lib.mkIf cfg.neovide.enable {
        neovide_transparency = 0.95;
      };

      diagnostics = {
        virtual_text = false;
      };

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
