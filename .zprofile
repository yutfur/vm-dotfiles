# パスの重複を無くす
typeset -T LD_LIBRARY_PATH ld_library_path; typeset -U ld_library_path
typeset -T LIBRARY_PATH library_path; typeset -U library_path
typeset -T CPATH cpath; typeset -U cpath
typeset -U path PATH cdpath fpath manpath

# $HOME/bin ディレクトリが存在するならば、このディレクトリのパスを通す
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# $HOME/.local/bin ディレクトリが存在するならば、このディレクトリのパスを通す
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Java の環境変数の設定
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export PATH="$PATH:$JAVA_HOME/bin"

# fcitx5 の環境変数の設定
export XMODIFIERS=@im=fcitx
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx

# デフォルトエディタを Vim にする
export EDITOR=vim

# 自動起動 (継続的に起動させるプログラムを実行するコマンドには末尾に & を付ける)
# vmware-user-suid-wrapper を起動する (ホスト OS とゲスト OS の間でクリップボード共有を有効化するため)
/usr/bin/vmware-user-suid-wrapper &
