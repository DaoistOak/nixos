{ config, pkgs, inputs, ... }:

{
  # Import configuration files
  imports = [
    ./hardware-configuration.nix
    ./pkgs.nix
    ./users.nix
    ./GUI.nix
    ./services.nix
  ];

  # System settings
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
    stateVersion = "25.11";
  };

  # Nix settings
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Bootloader settings
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking settings
  networking = {
    hostName = "Overlord";
    networkmanager = {
      enable = true;
      settings = {
        main = {
          connectivity = "true";
          connectivity-check-url = "https://connectivity-check.kde.org";
        };
      };
    };
  };


  # Localization settings
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  # Virtualization
  virtualisation.libvirtd = {
    enable = true;
    extraConfig = ''
      virtiofsd = "/run/current-system/sw/bin/virtiofsd"
    '';
  };

  # Console settings
  # /run/current-system/sw/share/consolefonts/ter-u16n.psfu.gz
  console.font = "/run/current-system/sw/share/consolefonts/ter-u18n.psf.gz";
}

