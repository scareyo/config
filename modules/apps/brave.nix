{
  flake.modules.homeManager.brave = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.brave;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      ];
    };
  };
}
