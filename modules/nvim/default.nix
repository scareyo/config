{ inputs, ... }:

{
  flake.modules.homeManager.nvim = { pkgs, ... }: {
    imports = [
      inputs.nixvim.homeModules.nixvim

      #./_plugins/just.nix
    ];

    home.packages = with pkgs; [
      ripgrep
      tree-sitter
    ];

    programs.nixvim = {
      enable = true;
      nixpkgs.source = inputs.nixpkgs;

      colorschemes.tokyonight.enable = true;

      autoCmd = import ./_autocmds.nix;
      keymaps = import ./_keymaps.nix;
      opts = import ./_options.nix;
      plugins = import ./_plugins.nix { inherit pkgs; };

      extraPlugins = [
        pkgs.vimPlugins.plenary-nvim
      ];

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

      diagnostic.settings = {
        virtual_text = false;
      };

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
