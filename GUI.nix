{ config, pkgs, inputs, ... }:
{
  # Enable X11
  services.xserver.enable = true;

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-macchiato";
  };
  # Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Enable Hyprland (Optional)
  programs.hyprland ={
    enable = true;
    xwayland.enable = true;
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
  services.pulseaudio.enable=false;
  # Enable real-time scheduling for better audio performance
  security.rtkit.enable = true;
}
