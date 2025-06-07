#
# ~/.bash_profile
#

# ~/.bashrc ファイルが存在するならば、それを現在のシェルで実行(読み込み)する
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

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

# Fcitx 5 の環境変数の設定
export XMODIFIERS=@im=fcitx

# デフォルトエディタを Vim にする
export EDITOR=vim

