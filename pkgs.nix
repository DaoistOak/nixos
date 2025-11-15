{pkgs,inputs,... }:

let
  catppuccin-sddm-custom = pkgs.catppuccin-sddm.override {
    flavor = "macchiato";
    accent = "mauve";
    font = "JetBrains Mono";
    fontSize = "9";
    background = "${./sddm/wallpaper}";
    loginBackground = true;
  };
in {

  # Nixpkgs settings
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
  };
  environment.systemPackages = with pkgs; [
    # inputs.zen-browser.packages."${system}".twilight-official
    inputs.zen-browser.packages."x86_64-linux".default
    inputs.winboat.packages.x86_64-linux.winboat
    fuse3
    waydroid

    # GUI Apps
    arduino-ide
    adi1090x-plymouth-themes
    appimage-run
    catppuccin-cursors.macchiatoLight
    catppuccin-kvantum
    catppuccin-papirus-folders
    catppuccin-sddm-custom
    code-cursor
    firefox
    gamescope
    genymotion
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.dragon
    kdePackages.flatpak-kcm
    kdePackages.kate
    kdePackages.kwallet-pam
    kdePackages.plasma-nm
    kdePackages.plymouth-kcm
    kdePackages.qtstyleplugin-kvantum
    kdePackages.sddm-kcm
    keepassxc
    kitty
    lact
    lutris
    networkmanagerapplet
    nexusmods-app
    brave
    protonvpn-gui
    popcorntime
    # nur.repos.shadowrz.klassy-qt6
    nur.repos.mikilio.ttf-ms-fonts
    papirus-folders
    qbittorrent
    steam
    syncthingtray
    terminus_font
    thunderbird
    times-newer-roman
    ungoogled-chromium
    vesktop
    virt-manager
    vscodium
    webcord-vencord
    wineWowPackages.waylandFull

    # CLI / TUI Tools
    btop
    fish
    fzf
    freerdp
    gnirehtet
    kdePackages.yakuake
    kitty
    lazydocker
    libnotify
    neovim
    oh-my-zsh
    tmux
    tabby
    tabby-agent
    vim
    vimPlugins.nvchad
    zoxide

    # CLI Executables
    alsa-utils
    amdgpu_top
    auto-cpufreq
    automake
    bat
    brightnessctl
    busybox
    cargo
    cmake
    cpufrequtils
    curl
    dnsmasq
    distrobox
    docker-compose
    eza
    ffmpeg
    flatpak
    gcc
    gdb
    git
    gnumake
    gnumake42
    jre
    kbd
    killall
    lazydocker
    lm_sensors
    mesa
    mesa-demos
    mpv
    ninja
    nodejs
    ntfs3g
    ollama
    openssl
    ocl-icd
    intel-compute-runtime 
    pciutils
    powertop
    preload
    psmisc
    pocl
    qemu
    qemu_kvm
    rocmPackages.clr
    speechd
    spice
    spice-gtk
    spice-vdagent
    swayidle
    syncthing
    tgpt
    thermald
    tlp
    unzip
    upower
    util-linux
    wget
    wl-clipboard
    xclip
    OVMF
    # CLI Libraries / Dev
    binutils
    bintools
    coreutils-full
    dxvk
    glibc
    glibc.dev
    icu77
    libdrm
    libgcc
    libgccjit
    libvirt
    libxkbcommon
    luarocks
    libva
    libvdpau
    libvdpau-va-gl
    mesa
    nil
    pkg-config
    radeontop
    virglrenderer
    virtiofsd
    vkd3d
    vkd3d-proton
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    zlib
    arduino-cli
    picocom
    screen
    # Tools
    home-manager
  ];
  virtualisation.docker.enable = true;
  services.flatpak.enable = true;
  users.extraGroups.docker.members = [ "zeph" ];
}
