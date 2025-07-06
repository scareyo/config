# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, self, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.configurationRevision = toString (self.shortRev or self.dirtyShortRev or "unknown");

  virtualisation.libvirtd.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "teseuka"; # Define your hostname.

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

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80    # HTTP
      8080  # HTTP
      47984 # Wolf (HTTPS)
      47989 # Wolf (HTTP)
      48010 # Wolf (RTSP)
      50042 # Omni (HTTP)
    ];
    allowedUDPPorts = [
      67    # DHCP
      69    # TFTP
      4011  # DHCP
      47999 # Wolf (Control)
      48100 # Wolf (Video)
      48200 # Wolf (Audio)
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Tablet
  hardware.opentabletdriver.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.flatpak.enable = true;

  # Games On Whales
  virtualisation = {
    containers.enable = true;
    docker.enable = true;

    oci-containers.backend = "docker";

    oci-containers.containers = {
      wolf = {
        image = "ghcr.io/games-on-whales/wolf:stable";
        environment = {
          XDG_RUNTIME_DIR = "/tmp/sockets";
          HOST_APPS_STATE_FOLDER = "/etc/wolf";
        };
        volumes = [
          "/etc/wolf/:/etc/wolf"
          "/tmp/sockets:/tmp/sockets:rw"
          "/var/run/docker.sock:/var/run/docker.sock:rw"
          "/dev/:/dev/:rw"
          "/run/udev:/run/udev:rw"
        ];
        extraOptions = [
          "--device-cgroup-rule" "c 13:* rmw"
        ];
        devices = [
          "/dev/dri"
          "/dev/uinput"
          "/dev/uhid"
        ];
        networks = [ "host" ];
      };
    };
  };

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.scarey = {
    isNormalUser = true;
    description = "Samuel Carey";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs = {
    overlays = [
      (final: prev: import ../../pkgs final.pkgs)
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    usbutils
    vim
    docker-compose  
  ];

  programs.steam.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
