{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

boot = {
  # --- Initrd & early modules ---
  initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  initrd.kernelModules = [ "amdgpu" ];

  # Core modules (added binder + ashmem)
  kernelModules = [
    "kvm-amd"
    "binder_linux"
    "ashmem_linux"
  ];

  # Needed for Waydroid binder functionality
  extraModprobeConfig = ''
    options binder_linux devices=binder,hwbinder,vndbinder
  '';

  # --- Kernel Parameters ---
  kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=auto"
  ];

  # --- Plymouth (Boot Splash) ---
  plymouth = {
    enable = true;
    theme = "seal_2";
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
  };
  # --- Kernel Packages ---
  # CachyOS kernel for performance (use linuxPackages_cachyos if built correctly)
  # kernelPackages = pkgs.linuxPackages_latest;
  # Alternatives:
  kernelPackages = pkgs.linuxPackages_zen;
  # kernelPackages = pkgs.linuxPackages_lqx;
  # kernelPackages = pkgs.linuxPackages_cachyos;

  # --- Bootloader ---
  loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
  };

  # --- Misc ---
  extraModulePackages = [ ];
};

hardware = {
  enableAllFirmware = true;
  enableRedistributableFirmware = true;

  amdgpu = {
    # Optional settings can go here
    opencl.enable = true; # if you use ROCm/OpenCL
  };

  cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  bluetooth.enable = true;

  graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa
      vulkan-loader         # ensures Vulkan runtime is installed
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.mesa
    ];
  };
};


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/810473a7-303c-422f-8044-62bb49e4dc40";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EEC0-0B8F";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a7075876-4a84-494a-a072-73f84a279086";
      fsType = "btrfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4d61df78-3b8d-477e-812d-f1fa35885a66"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

