{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    ntfs3g
    zsh
    fish
    code-cursor
    neovim
    vim
    git
    kitty
    cmake
    gnumake
    gnumake42
    libgcc
    libgccjit
    binutils
    bintools
    glibc
    pkg-config
    ninja
    zlib
    openssl
    curl
    wget
    gdb
    automake
    catppuccin-sddm
    catppuccin-cursors.macchiatoLight
    papirus-folders
    kdePackages.qtstyleplugin-kvantum
    catppuccin-kvantum
    catppuccin-papirus-folders
    nur.repos.shadowrz.klassy-qt6
    nur.repos.zzzsy.zen-browser
    nur.repos.mikilio.ttf-ms-fonts
    unzip
    lutris
    flatpak
    steam
    onlyoffice-desktopeditors
    onlyoffice-documentserver
    keepassxc
    syncthing
    ollama
    home-manager
    qt5.full
    oh-my-zsh
    zoxide
    eza
    kdePackages.flatpak-kcm
    spotify
    kdePackages.bluez-qt
    bluedevil
    vimPlugins.nvchad
    wineWowPackages.waylandFull
    ungoogled-chromium
    killall
    fzf
    btop
    ffmpeg
    virt-manager
    qemu
    libvirt
    OVMF
    dnsmasq
    virtiofsd
    nil
    times-newer-roman
    syncthing
    syncthingtray
    firefox
  ];

  # Enable Docker
  virtualisation.docker.enable = true;
    # Enable Flatpak
  services.flatpak.enable = true;
  users.extraGroups.docker.members = [ "zeph" ];
}
