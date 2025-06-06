#!/bin/bash

# Update & Upgrade packages (Official repositories & AUR)
# Use yay without sudo
yay -Syu

# Package list
packagelist=(

    # CPU/GPU Driver
    "mesa"
    "xf86-video-vmware"

    # VMware Tools
    "open-vm-tools"
    "gtkmm3"
    "xf86-input-vmmouse"

    # Input Device
    "imwheel"
    "input-remapper-git" # AUR
    #"piper"

    # USB
    #"ntfs-3g"

    # Wayland
    "wl-clipboard"
    #"xorg-xwayland"

    # UI
    #"plasma"

    # Audio
    "pipewire"

    # Image

    # Security
    #"clamav"
    #"ufw"

    # IME
    # Enter a selection に 1-4 (全て) と入力する
    "fcitx5-im"
    "fcitx5-mozc-ut" # AUR
    #"fcitx5-mozc"

    # Misc, Tools
    "man-db"
    "man-pages"
    "pacman-contrib"
    "hugo"
    "copyq"
    "chromium"

    # Terminal, Shell, Commands
    "zellij"
    "fzf"

    # Remote
    #"openssh"

    # Dev
    "gvim"
    "git"

    # Java
    "eclipse-java-bin" # AUR 、依存パッケージとして複数バージョンの JDK も一緒にインストールされる ( https://aur.archlinux.org/packages/eclipse-java-bin )

    # DB

)

# Install packages (from Official repositories & AUR)
for packages in "${packagelist[@]}"
do
    yay -S "${packages}"
done

# Clean unneeded dependencies
# apt autoremove, pacman -Rns "$(pacman -Qdtq)"
yay -Yc
