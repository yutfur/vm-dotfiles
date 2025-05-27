#!/bin/bash

# update & upgrade packages (Official repositories)
sudo pacman -Syu

# package list
packagelist=(

   # Display Server
   #"xorg-xwayland"

   # UI

   # Hardware
   "mesa"
   "xf86-video-vmware"
   "open-vm-tools"
   "gtkmm3"
   "xf86-input-vmmouse"
   "imwheel"
   #"ntfs-3g"

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
   "pacman-contrib"
   "copyq"
   "hugo"
   "chromium"
   #"p7zip"

   # Shell, Command
   "wezterm"
   "fzf"
   "curl"
   "wget"
   "ripgrep-all"
   "tree"
   "bat"
   "eza"
   "fd"
   #"lf"

   # Dev
   "git"
   "vim"

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
