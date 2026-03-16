# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, self, ... }:

{
  imports = [
    ./disk.nix
    ./hardware-configuration.nix
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

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable XDG Portal
  xdg.portal.enable = true;

  # Enable Input Remapper
  services.input-remapper.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.scarey = {
    isNormalUser = true;
    description = "Samuel Carey";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
  };

  programs.zsh.enable = true;

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

  # Enable Waydroid
  virtualisation.waydroid.enable = true;
  # Enable Docker
  virtualisation.docker.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

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
}

