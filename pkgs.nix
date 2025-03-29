{ pkgs, inputs, ... }:
{

  # Nixpkgs settings
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball {
          url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        }) { inherit pkgs; };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # GUI Packages
    catppuccin-cursors.macchiatoLight
    catppuccin-kvantum
    catppuccin-papirus-folders
    catppuccin-sddm
    code-cursor
    kdePackages.bluez-qt
    kdePackages.bluedevil
    kdePackages.flatpak-kcm
    kdePackages.kate
    kdePackages.qtstyleplugin-kvantum
    kdePackages.sddm-kcm
    kdePackages.plasma-nm
    kdePackages.dragon
    lutris
    onlyoffice-desktopeditors
    onlyoffice-documentserver
    papirus-folders
    syncthingtray
    ungoogled-chromium
    virt-manager
    wineWowPackages.waylandFull
    keepassxc
    home-manager
    oh-my-zsh
    nil
    times-newer-roman
    firefox
    qbittorrent
    discord
    thunderbird
    # TUI Packages
    automake
    btop
    busybox
    cmake
    curl
    coreutils-full
    gcc
    glibc
    glibc.dev
    binutils
    dnsmasq
    eza
    ffmpeg
    fish
    flatpak
    fzf
    git
    glibc
    gnumake
    gnumake42
    killall
    libgcc
    libgccjit
    libvirt
    virtiofsd
    ninja
    openssl
    ollama
    pkg-config
    qemu
    qt5.full
    syncthing
    unzip
    vim
    vimPlugins.nvchad
    wget
    zlib
    zoxide
    ntfs3g
    neovim
    kitty
    bintools
    gdb
    OVMF
    amdgpu_top
    mesa
    wl-clipboard
    xclip
    kbd
    terminus_font
    tmux
    nodejs
    psmisc

    bat
    docker-compose
    lazydocker
    luarocks
    cargo
    lm_sensors
    brightnessctl
    mesa
    mesa-demos
    vulkan-tools
    amdvlk
    pciutils
    radeontop
    spice
    spice-vdagent
    virglrenderer
    appimage-run
    util-linux
    swayidle
    #Power Managemant
    auto-cpufreq
    tlp
    preload
    powertop
    thermald
    cpufrequtils
    upower
    jre
    distrobox
    # NUR Packages
    nur.repos.mikilio.ttf-ms-fonts
    nur.repos.shadowrz.klassy-qt6
    # nur.repos.zzzsy.zen-browser
  ];
  fonts = {
    packages = with pkgs; [ terminus_font ];
  };


  # Enable Docker
  virtualisation.docker.enable = true;
    # Enable Flatpak
  services.flatpak.enable = true;
  users.extraGroups.docker.members = [ "zeph" ];
}
