{ config, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "scarey";
  home.homeDirectory = "/home/scarey";

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = "sam@scarey.me";
      gpgPath = "/mnt/c/Users/scarey/scoop/apps/gpg4win/current/GnuPG/bin/gpg.exe";
    };

    nvim.enable = true;
    zsh.enable = true;
  };

  home.activation.windowsTools = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/bin
    ln -sf /mnt/c/Windows/System32/OpenSSH/ssh.exe ~/bin/ssh
    ln -sf /mnt/c/Users/scarey/scoop/apps/gpg4win/current/GnuPG/bin/gpg.exe ~/bin/gpg
  '';
  
  home.stateVersion = "24.05";
}
