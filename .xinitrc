#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# feh --bg-center /path/to/img_file で壁紙を設定 (メインモニター → サブモニターの順で設定される)
feh --bg-fill $HOME/pictures/wallpaper/arch-linux-dark-4k-ee.jpg
#feh --bg-fill $HOME/pictures/wallpaper/ryo-yoshitake-cnIK3nLZ0Sg-unsplash.jpg --bg-fill $HOME/pictures/wallpaper/ren-huixin-H_bvmLzPjyc-unsplash.jpg

# 一定時間経過後のモニターオフを無効化
xset s off -dpms

# input remapper の全プリセットをロード
input-remapper-control --command autoload

# 自動起動 (継続的に起動させるプログラムを実行するコマンドには末尾に & を付ける)
# vmware-user-suid-wrapper を起動する (ホスト OS とゲスト OS の間でクリップボード共有を有効化するため)
/usr/bin/vmware-user-suid-wrapper &
# polkit-gnome ( timeshift を GUI で起動させるため)
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# Polybar (起動を少し遅らせる)
sleep 2 && $HOME/vm-dotfiles/.config/polybar/launch.sh &
# CopyQ (起動を少し遅らせないとトレイアイコンが表示されなくなる場合がある)
sleep 5 && copyq &
# IMWheel
imwheel &

# i3 を自動起動する
# 一番下の行に置く
exec i3


