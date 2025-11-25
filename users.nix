{ config, pkgs, ... }:

{
  # Define user accounts
  users.users.zeph = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "SD";
    extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" "kvm" "qemu-libvirtd" "nixos" "dialout" "video" "render" "seat" "docker"];
  };

  # User-specific environment variables
  environment.variables = {
    ZDOTDIR = "/home/zeph/.config/zsh";
    XDG_CONFIG_HOME = "/home/zeph/.config";
    XDG_DATA_HOME = "/home/zeph/.local/share";
    XDG_CACHE_HOME = "/home/zeph/.cache";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/radeon_icd.i686.json";
  };
#   environment.sessionVariables = {
#     # Stabilize XWayland socket
#     DISPLAY = ":0";
#     # Reduce KWin effects that conflict with games
# XWAYLAND_NO_GLAMOR = "0";
# __GLX_VENDOR_LIBRARY_NAME = "mesa";
# WINE_FORCE_WAYLAND = "0";
#     KWIN_XWAYLAND_NO_SCALE = "1";
#     KWIN_COMPOSE = "O";
#     STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/run/current-system/sw/share/steam/compatibilitytools.d";  # If using custom Proton
#     # Force Steam to prefer Wayland where possible
#     SDL_VIDEODRIVER = "wayland";
#     QT_QPA_PLATFORM = "wayland";
#   };
  # Enable Zsh
  programs.zsh.enable = true;
  programs.direnv.enableZshIntegration=true;

  # Enable Docker and add user to the group
  virtualisation.waydroid.enable = true; 
  users.extraGroups.docker.members = [ "zeph" ];
 }
