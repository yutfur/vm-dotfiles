# fzf 有効化
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# fzf 絞り込み画面の高さ調整(--height)、上下表示(--reverse : 逆)、枠線表示(--border)
# https://wonderwall.hatenablog.com/entry/2017/10/06/063000
export FZF_DEFAULT_OPTS='--height 95% --reverse --border'

# 基本設定
source $HOME/vm-dotfiles/zsh/general.zsh

# プラグイン
source $HOME/vm-dotfiles/zsh/plugins.zsh

# 関数
source $HOME/vm-dotfiles/zsh/functions.zsh

# エイリアス
source $HOME/vm-dotfiles/zsh/aliases.zsh

# キーバインド
source $HOME/vm-dotfiles/zsh/keybindings.zsh

# ターミナル起動時に tmux 自動起動 (デタッチしたセッションが存在しなければ新しいセッションで起動し、デタッチしたセッションが存在すれば直近のセッションで起動する)
# https://www.mk-mode.com/blog/2013/06/06/linux-mint-tmux-auto-attach/
# if [ -z $TMUX ]; then
#   if $(tmux has-session 2> /dev/null); then
#     tmux -2 attach
#   else
#     tmux -2
#   fi
# fi

