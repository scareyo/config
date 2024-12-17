{ config, lib, ... }:

{
  options = with lib; {
    scarey.home.zsh.enable = mkEnableOption "Enable zsh configuration";
  };
  
  config = lib.mkIf config.scarey.home.zsh.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      silent = true;
      nix-direnv.enable = true;
    };
    programs.zsh = {
      enable = true;

      antidote = {
        enable = true;
        plugins = [
          "romkatv/powerlevel10k"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-history-substring-search"
          "zsh-users/zsh-syntax-highlighting"
        ];
      };

      shellAliases = {
        ll = "ls -l";
      };

      initExtra = ''
        source ${ ./config/p10k_v2.zsh }
        export KEYTIMEOUT=1
        export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
        export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""

        export PATH=$PATH:~/bin

        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down

        bindkey "^H" backward-delete-char
        bindkey "^?" backward-delete-char
      '';
    };
  };
}
