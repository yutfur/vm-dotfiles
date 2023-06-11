# -------------------------------------------------------------------------------------------
# プラグイン
# -------------------------------------------------------------------------------------------

# プラグインマネージャ zinit
# プラグイン追加の記述後に zsh を再起動すれば自動的にプラグインがインストールされる
# zinit の自動インストーラーも兼ねているので、以下によって zinit をインストールしたら zsh を再起動して zinit self-update を実行する

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-{'readurl','bin-gem-node','patch-dl','rust'}

### End of Zinit's installer chunk

# プロンプト・テーマ ($ p10k configure で 初期化)
zinit ice depth=1; zinit light romkatv/powerlevel10k
# powerlevel10k テーマの読み込み
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# コマンドのシンタックスハイライト
zinit light zdharma-continuum/fast-syntax-highlighting

# Tabキーでのコマンド補完
zinit light zsh-users/zsh-completions

# コマンド履歴からのコマンド補完
zinit light zsh-users/zsh-autosuggestions
