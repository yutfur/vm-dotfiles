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

    # Terminal, Shell, Command
    "zellij"
    "fzf"

    # Dev
    "git"

    # Java

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

    "eclipse-java-bin" # 依存パッケージとして複数バージョンの JDK も一緒にインストールされる

)

# Install AUR packages
for packages in "${aurs[@]}"
do
    yay -S "${packages}"
done

# Clean unneeded dependencies
# apt autoremove, pacman -Rns "$(pacman -Qdtq)"
yay -Yc
