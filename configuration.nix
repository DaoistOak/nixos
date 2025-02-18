{ config, pkgs, ... }:

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
    stateVersion = "24.11";
  };

  # Nix settings
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
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
    networkmanager.enable = true;
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
  # Nixpkgs settings
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball {
          url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        }) { inherit pkgs; };
      };
    };
  };
}

