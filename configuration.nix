{ config, pkgs, ... }:

{
  # Import configuration files
  imports = [
    ./hardware-configuration.nix
    ./pkgs.nix
    ./users.nix
    ./GUI.nix
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
  console.font = "ter-u16n";
  # Services configuration
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    blueman.enable = false;
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_BOOST_ON_BAT = 0;
        CPU_BOOST_ON_AC = 1;
        WIFI_PWR_ON_BAT = "on";
        RUNTIME_PM_ON_BAT = "auto";
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi wwan";
        DEVICES_TO_ENABLE_ON_AC = "bluetooth wifi wwan";
      };
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
   preload.enable = true;
  };
  powerManagement.powertop.enable = true;
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

