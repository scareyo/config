{ config, inputs, self, ... }:

{
  flake.nixosConfigurations.teseuka = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with config.flake.modules.nixos; [
      teseuka
      gnome
      zsh
    ];
  };

  flake.modules.nixos.teseuka = { pkgs, ... }: {
    imports = [
      inputs.disko.nixosModules.disko
      ./_disk.nix
      ./_hardware-configuration.nix
    ];

    system.configurationRevision = toString (self.shortRev or self.dirtyShortRev or "unknown");

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Load amdgpu at stage 1
    hardware.amdgpu.initrd.enable = true;

    # Drives
    fileSystems."/data" = {
      device = "/dev/disk/by-uuid/b80e74f3-c6ac-4468-982b-c874f133e1fa";
      fsType = "btrfs";
    };

    # Auto upgrade
    system.autoUpgrade = {
      enable = true;
      flake = "github:scareyo/config";
      dates = "07:00 UTC";
    };

    # Set hostname
    networking.hostName = "teseuka";

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Enable nftables
    networking.nftables.enable = true;

    # Open ports
    networking.firewall = {
      allowedTCPPorts = [
        8080
        50084   # Talos Booter
      ];
      allowedUDPPorts = [
        67      # DHCP
        69      # TFTP
        4011    # ProxyDHCP
      ];
    };

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable Input Remapper
    services.input-remapper.enable = true;

    # Enable sound.
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    services.meshcentral.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.scarey = {
      isNormalUser = true;
      description = "Samuel Carey";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "docker" ];
    };

    # Nix Settings
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      vim
      wl-clipboard
    ];

    # Enable Docker
    virtualisation.docker.enable = true;

    # Enable virtual machines
    virtualisation.libvirtd.enable = true;

    programs.virt-manager.enable = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # Enable Steam
    programs.steam.enable = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
