#!/bin/bash

# Update & Upgrade packages (Official repositories)
sudo pacman -Syu

# Package list
packagelist=(

   # Hardware
   "mesa"
   "xf86-video-vmware"
   "open-vm-tools"
   "gtkmm3"
   "xf86-input-vmmouse"
   "imwheel"
   #"ntfs-3g"

   # Wayland
   #"xorg-xwayland"

   # UI

   # Audio
   "pipewire"

   # Image

   # Security
   #"clamav"
   #"ufw"

   # IME
   # Enter a selection に 1-4 (全て) と入力する
   "fcitx5-im"
   "fcitx5-mozc"

   # Misc, Tools
   "gvim"
   "man-db"
   "man-pages"
   "pacman-contrib"
   "hugo"
   "copyq"
   "chromium"

   # LF
   "lf"
   # Preview (ctpv)
   # https://github.com/NikitaIvanovV/ctpv
   # pdftoppm は poppler に同梱されている
   "chafa"
   "ffmpegthumbnailer"
   "poppler"
   #"w3m"
   #"mdcat"
   #"jq"
   #"fontimage"
   #"convert"

   # Terminal, Shell, Command
   "zellij"
   "fzf"

   # Dev
   "git"

   # Java
   "jdk17-openjdk"

   # DB

)

# Install packages
for packages in "${packagelist[@]}"
do
   sudo pacman -S --noconfirm "${packages}"
done

# Update & Upgrade packages (AUR)
# Use yay without sudo
yay -Syu

# AUR package list
aurs=(

   "visual-studio-code-bin"
   "ctpv-git"

)

# Install AUR packages
for packages in "${aurs[@]}"
do
   yay -S "${packages}"
done

# Clean unneeded dependencies
# apt autoremove, pacman -Rns "$(pacman -Qdtq)"
yay -Yc
