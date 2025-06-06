#!/bin/bash

# ホームディレクトリ内に bin, ~/Pictures/wallpaper, ~/Pictures/screenshots ディレクトリを作成
for d in "bin"
do
    mkdir -p "${HOME}"/"${d}"
done

mkdir -p "${HOME}"/Pictures/wallpaper
mkdir -p "${HOME}"/Pictures/screenshots

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

# Bash
# .blerc のシンボリックリンクを $HOME 直下に貼る
ln -snfv "${DOTFILES_PATH}"/bash/.blerc "${HOME}"/.blerc

# Vim
# Vim 用のディレクトリを作成
for d in "recovery" "colors"
do
    mkdir -p "${HOME}"/.vim/"${d}"
done
# Vim 用のカラースキームをコピー
cp -i "${DOTFILES_PATH}"/.vim/colors/* "${HOME}"/.vim/colors/
# vimrc のシンボリックリンクを $HOME/.vim 直下に貼る
ln -snfv "${DOTFILES_PATH}"/.vim/vimrc "${HOME}"/.vim/vimrc

# $HOME/.config/... ディレクトリを作成
for d in "zellij"
do
    mkdir -p "${HOME}"/.config/"${d}"
done

# Zellij
# config.kdl のシンボリックリンクを $HOME/.config/zellij 直下に貼る
ln -snfv "${DOTFILES_PATH}"/.config/zellij/config.kdl "${HOME}"/.config/zellij/config.kdl

