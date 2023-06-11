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

# デフォルトエディタを Neovim にする
export EDITOR=nvim

# デフォルトターミナルを WezTerm にする
export TERMINAL=wezterm

# fcitx5 の環境変数の設定
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# ログイン時に X を自動起動 ( ~/.xinitrc を読み込む)
# 一番下の行に置く
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

