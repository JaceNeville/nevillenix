# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # System State Version (do not change unless you know what you're doing)
  system.stateVersion = "23.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  programs.nix-ld.enable = true;


  # Time zone and locale settings
  time.timeZone = "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  # X11 and GNOME
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Sound settings
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Basic services
  services = {
    printing.enable = true;
    tailscale.enable = true;
    plex = {
      enable = true;
      openFirewall = true;
    };
    nfs.server.enable = true;
  };

  # Ensure kernel support for network filesystems used by mounts
  boot.supportedFilesystems = [ "nfs" ];

  # Docker configuration
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # NFS Mount Media
  #fileSystems."/media" = {
  #  device = "100.82.183.73:/mnt/main_pool/media";
  #  fsType = "nfs";
  #  options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  #};

  # NFS Mount media/tv
  fileSystems."/tv" = {
    device = "100.99.106.71:/mnt/main_pool/media/tv";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };
 
  # NFS Mount media/movies
  fileSystems."/movies" = {
    device = "100.99.106.71:/mnt/main_pool/media/movies";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };

  # User configuration
  users.users.nevillecasaadmin = {
    isNormalUser = true;
    description = "Jace Neville";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Basic system packages
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    docker-compose
  ];

  # Basic firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 32400 9000 8409 34400 ];
  };

  # Docker container services
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      ersatztv = {
        image = "jasongdove/ersatztv:latest";
        autoStart = true;
        ports = [
          "34400:34400"
        ];
        volumes = [
          "/var/lib/ersatztv:/root/.local/share/ersatztv"
          "/movies:/movies:ro"
          "/tv:/tv:ro"
        ];
        environment = {
          TZ = "America/Chicago";
          PUID = "1000";
          PGID = "1000";
        };
        extraOptions = [
          "--network=host"
        ];
      };

      xteve = {
        image = "alturismo/xteve:latest";
        autoStart = true;
        ports = [
          "8409:34400"
        ];
        volumes = [
          "/var/lib/xteve:/root/.xteve:rw"
          "/tmp/xteve:/tmp/xteve:rw"
        ];
        environment = {
          TZ = "America/Chicago";
        };
      };
    };
  };

  # Create necessary directories
  system.activationScripts = {
    createMediaDirs = {
      text = ''
        mkdir -p /var/lib/ersatztv
        mkdir -p /var/lib/xteve
        mkdir -p /tmp/xteve
        chmod 755 /var/lib/ersatztv
        chmod 755 /var/lib/xteve
        chmod 755 /tmp/xteve
      '';
      deps = [];
    };
  };

  
  



};
