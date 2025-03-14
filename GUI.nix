{ config, pkgs, ... }:

{
  # Enable X11
  services.xserver.enable = true;

  # Enable KDE Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable Hyprland (Optional)
  programs.hyprland ={
    enable = true;
    xwayland.enable=true;
  };

  # PipeWire (Audio)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # Enable WirePlumber (PipeWire Session Manager)
  services.pipewire.wireplumber.enable = true;

  # Enable real-time scheduling for better audio performance
  security.rtkit.enable = true;
}
