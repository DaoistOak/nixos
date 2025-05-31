{ pkgs, inputs, ... }:
let
  catppuccin-sddm-custom = pkgs.catppuccin-sddm.override {
    flavor = "macchiato";
    font = "JetBrains Mono";
    fontSize = "9";
    background = "./sddm/wallpaper";
    loginBackground = true;
  };
in{

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
adi1090x-plymouth-themes
amdvlk
appimage-run
brave
catppuccin-cursors.macchiatoLight
catppuccin-kvantum
catppuccin-papirus-folders
catppuccin-sddm-custom
code-cursor
firefox
gamescope
kdePackages.bluedevil
kdePackages.bluez-qt
kdePackages.dragon
kdePackages.flatpak-kcm
kdePackages.kate
kdePackages.plasma-nm
kdePackages.plymouth-kcm
kdePackages.qtstyleplugin-kvantum
kdePackages.sddm-kcm
keepassxc
kitty
lutris
networkmanagerapplet
nur.repos.shadowrz.klassy-qt6
nur.repos.mikilio.ttf-ms-fonts
onlyoffice-desktopeditors
onlyoffice-documentserver
papirus-folders
qbittorrent
syncthingtray
terminus_font
thunderbird
times-newer-roman
ungoogled-chromium
vesktop
virt-manager
webcord-vencord
wineWowPackages.waylandFull

# CLI Packages (Divided into TUI, CLI with executables, CLI without executables)

## TUI Packages (interactive terminal UIs)
btop
fish
fzf
kitty
lazydocker
neovim
oh-my-zsh
tmux
vim
vimPlugins.nvchad
zoxide

## CLI Packages with Executable Programs
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
ninja
nodejs
ntfs3g
ollama
openssl
pciutils
powertop
preload
psmisc
qemu
qemu_kvm
radeontop
spice
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

## CLI Packages without Executables (Libraries, headers, dev files)
binutils
bintools
coreutils-full
glibc
glibc.dev
libdrm
libgcc
libgccjit
libvirt
libxkbcommon
luarocks
mesa
nil
pkg-config
qt5.full
radeontop
virglrenderer
virtiofsd
vulkan-loader
vulkan-tools
vulkan-validation-layers
zlib

# Additional Tools
home-manager
# nur.repos.zzzsy.zen-browser  # (Commented out as requested)
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
