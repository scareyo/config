{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      fidget.enable = true;
      notify.enable = true;
      telescope.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPlugin {
        name = "just.nvim";
        version = "2024-08-31";
        src = pkgs.fetchFromGitHub {
          owner = "al1-ce";
          repo = "just.nvim";
          rev = "664930c4791d92a88b8792e1e32a42275bef3fa4";
          sha256 = "189s0vfrw39f2c3h9vj3wsh9102ay49blh7hm7v617f50dzja057";
        };
      })

      plenary-nvim
    ];

    extraConfigLua = ''
      require('just').setup({
        fidget_message_limit = 32, -- limit for length of fidget progress message 
        play_sound = false, -- plays sound when task is finished or failed
        open_qf_on_error = true, -- opens quickfix when task fails
        open_qf_on_run = true, -- opens quickfix when running `run` task (`:JustRun`)
        telescope_borders = { -- borders for telescope window
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" }, 
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
        }
      })
    '';
  };
}
