{ config, pkgs, ... }:

{
  # Import configuration files
  imports =
    [
      ./hardware-configuration.nix
      ./pkgs.nix
      ./users.nix
      ./GUI.nix
    ];

  # Automatic updates and garbage collection
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 3d";
  nix.settings.auto-optimise-store = true;

  # Bootloader and system settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set system hostname
  networking.hostName = "Overlord";

  # Network management
  networking.networkmanager.enable = true;

  # Set time zone and locale
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  # Virtualization (Libvirt, QEMU, VirtioFS)
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.extraConfig = ''
    virtiofsd = "/run/current-system/sw/bin/virtiofsd"
  '';

  # Configure keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NUR (Nix User Repository) integration
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    }) { inherit pkgs; };
  };

  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Define system state version
  system.stateVersion = "24.11";
}
