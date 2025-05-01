{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amdgpu.runpm=1" ];
  boot.plymouth = { 
    enable = true;
    theme = "seal_2";
    themePackages = [
      (pkgs.runCommand "adi1090x-plymouth-themes" { } ''
        mkdir -p $out/share/plymouth/themes
        cp -r ${/nix/store/gnn56cmpj4ch8glilj120k4ld4gvxlwa-adi1090x-plymouth-themes-1.0}/share/plymouth/themes/* $out/share/plymouth/themes/
      '')
    ];
  };
  boot.extraModulePackages = [ ];
  # Set the CachyOS kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # boot.kernelPackages = with pkgs; linuxPackagesFor linuxPackages_cachyos;
  hardware = {
    enableRedistributableFirmware = true;
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
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;

}
