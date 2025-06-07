#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Oh My Posh
eval "$(oh-my-posh init bash --config $HOME/vm-dotfiles/bash/oh-my-posh/honukai.omp.json)"

# エイリアス (設定しすぎないこと)
# dircolors
eval $(dircolors $HOME/vm-dotfiles/bash/dircolors/solarized/dircolors.ansi-light)
# ls
alias ls='ls -alF --color=auto'
# grep
alias grep='grep --color=auto'

# ターミナル起動時に tmux 自動起動 (デタッチしたセッションが存在しなければ新しいセッションで起動し、デタッチしたセッションが存在すれば直近のセッションで起動する)
# https://www.mk-mode.com/blog/2013/06/06/linux-mint-tmux-auto-attach/
# if [ -z $TMUX ]; then
#   if $(tmux has-session 2> /dev/null); then
#     tmux -2 attach
#   else
#     tmux -2
#   fi
# fi

# FZF 有効化
# Set up fzf key bindings and fuzzy completion ( https://github.com/junegunn/fzf )
eval "$(fzf --bash)"

