{
  flake.modules.homeManager.git = { lib, ... }: {
    programs.git = {
      enable = true;
      signing = {
        format = "openpgp";
        key = null;
        signByDefault = true;
      };
      settings = {
        user.name = lib.mkDefault "Samuel Carey";
        user.email = lib.mkDefault "sam@scarey.me";
        diff.tool = "nvimdiff";
      };
    };
  };
}
