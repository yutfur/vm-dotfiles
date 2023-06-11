# -------------------------------------------------------------------------------------------
# キーバインド
# -------------------------------------------------------------------------------------------

# vim のキーバインドを使用
# 入力・挿入モード(iで切り替え) プロンプト記号:>
# ノーマルモード(Escで切り替え) プロンプト記号:<
# ビジュアルモード(vで切り替え) プロンプト記号:v
bindkey -v

# 補完候補のメニュー選択で、矢印キーの代わりに h,j,k,l で移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# BackSpace が効かなくなる問題の修正
# https://vi.stackexchange.com/questions/31671/set-o-vi-in-zsh-backspace-doesnt-delete-non-inserted-characters
# https://github.com/spaceship-prompt/spaceship-prompt/issues/91
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# vim のキーバインド使用時でも Esc + q でコマンドラインスタックを使う
bindkey '^[q' push-line-or-edit
