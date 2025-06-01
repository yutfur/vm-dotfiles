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

# $HOME/.config/... ディレクトリを作成
for d in "lf"
do
    mkdir -p "${HOME}"/.config/"${d}"
done

# Vim
# Vim 用のディレクトリを作成
for d in "recovery"
do
    mkdir -p "${HOME}"/.vim/"${d}"
done
# $HOME/.vimrc をシンボリックリンクとして作成する
ln -snfv "${DOTFILES_PATH}"/.vim/vimrc "${HOME}"/.vimrc
