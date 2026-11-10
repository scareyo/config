{
  flake.modules.nixos.gnome = {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Enable XDG Portal
    xdg.portal.enable = true;
  };

  flake.modules.homeManager.gnome = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnome-tweaks
      rewaita
    ];

    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs; [
        { package = gnomeExtensions.dash-to-dock; }
        { package = gnomeExtensions.user-themes; }
      ];
    };

    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [];
        switch-applications-backward = [];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "rewaita";
      };
    };
  };
}
