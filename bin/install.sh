#!/bin/bash

# update & upgrade packages (Official repositories)
sudo pacman -Syu

# package list
packagelist=(

   # Display Server
   #"xorg-xwayland"

   # UI

   # Hardware
   "open-vm-tools"
   "gtkmm3"
   "xf86-video-vmware"
   "mesa"
   "xf86-input-vmmouse"
   "ntfs-3g"
   "imwheel"
   #"piper"

   # Audio
   "pipewire"
   #"playerctl"

   # Image
   #"imv"

   # Preview (ctpv)
   # https://github.com/NikitaIvanovV/ctpv
   # pdftoppm は poppler に同梱されている
   #"chafa"
   #"ffmpegthumbnailer"
   #"poppler"
   #"w3m"
   #"mdcat"
   #"jq"
   #"fontimage"
   #"convert"

   # Security
   #"polkit"
   #"polkit-gnome"
   #"libsecret"
   #"gnome-keyring"
   #"clamav"
   #"ufw"

   # IME
   # Enter a selection に 1-4 (全て) と入力する
   "fcitx5-im"
   "fcitx5-mozc"

   # Misc, Tools
   "man-db"
   "man-pages"
   "timeshift"
   "hugo"
   "copyq"
   "pacman-contrib"
   "chromium"
   #"libreoffice-still"
   #"libreoffice-still-ja"
   #"p7zip"

   # Shell, Command
   "wezterm"
   "zsh"
   "curl"
   "wget"
   "ripgrep-all"
   "tree"
   "bat"
   "eza"
   "fd"
   "fzf"
   #"lf"
   #"gnome-terminal"

   # Dev
   "git"
   "neovim"
   #"vi"

   # Java
   "jdk17-openjdk"

   # DB

)

# install packages
for packages in "${packagelist[@]}"
do
   sudo pacman -S --noconfirm "${packages}"
done

# install AUR helper paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru || exit
makepkg -si
cd ..
rm -rf paru

# update & upgrade packages (Official repositories and AUR)
# Use paru without sudo
paru -Syu

# aur package list
aurs=(
   "visual-studio-code-bin"
   "input-remapper-git"
   #"ctpv-git"
)

# install AUR packages
for packages in "${aurs[@]}"
do
   paru -S "${packages}"
done

# autoremove
# sudo pacman -Rns "$(pacman -Qdtq)"
paru -c
