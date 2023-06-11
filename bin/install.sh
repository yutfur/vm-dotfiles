#!/bin/bash

# update & upgrade packages (Official repositories)
sudo pacman -Syu

# package list
packagelist=(

   # X
   "xorg-server"
   "xorg-xinit"
   "xorg-xrandr"
   "arandr"
   "xdg-utils"
   "xclip"

   # UI
   "i3-wm"
   "i3lock"
   "i3status"
   "rofi"
   "polybar"
   "libnotify"
   "notification-daemon"

   # Hardware
   "open-vm-tools"
   "gtkmm3"
   "xf86-video-vmware"
   "mesa"
   "xf86-input-vmmouse"
   "ntfs-3g"
   #"piper"

   # IME
   # Enter a selection に 1-4 (全て) と入力する
   "fcitx5-im"
   "fcitx5-mozc"

   # Security
   "polkit"
   "polkit-gnome"
   "libsecret"
   "gnome-keyring"
   #"clamav"
   #"ufw"

   # Audio
   "pipewire"
   "playerctl"

   # Image
   "feh"

   # Preview (ctpv)
   # https://github.com/NikitaIvanovV/ctpv
   # chafa ではプレビューできない
   # pdftoppm は poppler に同梱されている
   "ueberzug"
   "ffmpegthumbnailer"
   "poppler"
   #"w3m"
   #"mdcat"
   #"jq"
   #"fontimage"
   #"convert"

   # Misc
   "man-db"
   "man-pages"
   "hugo"
   "copyq"
   "p7zip"
   "pacman-contrib"
   "chromium"
   #"libreoffice-still"

   # Shell, Command
   "wezterm"
   "gnome-terminal"
   "zsh"
   "curl"
   "wget"
   "ripgrep-all"
   "tree"
   "bat"
   "exa"
   "fd"
   "fzf"
   "lf"

   # Dev
   "git"
   "neovim"
   "vi"

   # Java Dev
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
   "timeshift"
   "input-remapper-git"
   "man-pages-ja"
   "ctpv-git"
)

# install AUR packages
for packages in "${aurs[@]}"
do
   paru -S "${packages}"
done

# autoremove
# sudo pacman -Rns "$(pacman -Qdtq)"
paru -c
