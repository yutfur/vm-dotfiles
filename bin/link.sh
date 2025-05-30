#!/bin/bash

# ホームディレクトリ内に bin, downloads, pictures, ~/pictures/wallpaper, ~/pictures/screenshots ディレクトリを作成
for d in "bin" "downloads" "pictures"
do
    mkdir -p "${HOME}"/"${d}"
done

mkdir -p "${HOME}"/pictures/wallpaper
mkdir -p "${HOME}"/pictures/screenshots

# $HOME/vm-dotfiles に移動
DOTFILES_PATH="${HOME}/vm-dotfiles"
cd "${DOTFILES_PATH}" || exit

# $HOME/vm-dotfiles 直下にあるドット始まりの2文字以上のファイルやディレクトリを取得し、それぞれに対するシンボリックリンクをホームディレクトリに貼る
for f in .??*
do
    # ホームディレクトリにシンボリックリンクを貼らない(除外する) $HOME/vm-dotfiles 直下のドット始まりのファイルやディレクトリを指定
    [ "${f}" = ".git" ] && continue
    [ "${f}" = ".gitignore" ] && continue
    [ "${f}" = ".config" ] && continue

    ln -snfv "${DOTFILES_PATH}"/"${f}" "${HOME}"/"${f}"
done

# $HOME/.config/... ディレクトリを作成
for d in "nvim"
do
    mkdir -p "${HOME}"/.config/"${d}"
done

# Neovim 用のディレクトリを作成
for d in "swap" "undo" "plugged"
do
    mkdir -p "${HOME}"/.local/share/nvim/"${d}"
done
# Neovim 用のカラースキームをコピー
# lightline.vim 用のカラースキームは、lightline.vim をインストールする前に配置すると、エラーが起きて lightline.vim がインストールできなくなる・されなくなるので、lightline.vim をインストールした後に配置する必要がある (詳細は arch-settings.md の dotfiles の項を参照)
mkdir -p "${HOME}"/.config/nvim/colors
cp -i "${DOTFILES_PATH}"/.config/nvim/colors/colorscheme/* "${HOME}"/.config/nvim/colors/
# init.vim のシンボリックリンクを $HOME/.config/nvim 直下に貼る
ln -snfv "${DOTFILES_PATH}"/.config/nvim/init.vim "${HOME}"/.config/nvim/init.vim

