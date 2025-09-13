{ config, pkgs, ... }:

{
  # Define user accounts
  users.users.zeph = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "SD";
    extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" "kvm" "qemu-libvirtd" "nixos" "dialout" "video" "render" "seat"];
  };

  # User-specific environment variables
  environment.variables = {
    ZDOTDIR = "/home/zeph/.config/zsh";
    XDG_CONFIG_HOME = "/home/zeph/.config";
    XDG_DATA_HOME = "/home/zeph/.local/share";
    XDG_CACHE_HOME = "/home/zeph/.cache";
  };

  # Enable Zsh
  programs.zsh.enable = true;
  programs.direnv.enableZshIntegration=true;

  # Enable Docker and add user to the group
  virtualisation.waydroid.enable = true; 
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "zeph" ];
 }
