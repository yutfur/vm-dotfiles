# -------------------------------------------------------------------------------------------
# 基本設定
# -------------------------------------------------------------------------------------------

# 日本語を使う
export LANG="ja_JP.UTF-8"

# 色を使用できるようにする
autoload -U colors && colors

# 日本語ファイル名等、8ビットを通す
setopt print_eight_bit

# Ctrl+S,Q によるフロー制御を使わないようにする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# コマンドライン上でも '#' 以降をコメントとして扱う
setopt interactive_comments

# 単語の区切り文字を指定する
# ここで指定した文字は単語区切りとみなされる
# Ctrl+W で前(左)の単語を削除する際は区切り文字までの単語までしか削除しない
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./=;@:{},|"
zstyle ':zle:*' word-style unspecified

# BEEP を鳴らさない
setopt no_beep

# シンボリックリンクは実体を追うようになる
# setopt chase_links

# bgプロセスの状態変化を即時に知らせる
# setopt notify

# プロンプト文字列内でパラメータの展開、コマンドの置換、算術演算の展開を行なう(プロンプト内での置換はコマンドの状態には影響しない)
# setopt prompt_subst

# 全てのユーザのログイン・ログアウトを監視する
# watch="all"
# ログイン時にはすぐに表示する
# log

# -------------------------------------------------------------------------------------------
# コマンド機能拡張
# -------------------------------------------------------------------------------------------

# パスを直打ちしてディレクトリ移動できるようにする (cd を入力しなくて良い)
# setopt auto_cd

# cdの後にlsを実行 (https://qiita.com/d-dai/items/d7f329b7d82e2165dab3)
# chpwd() { ls -aF --color=auto }
chpwd() { exa --icons -aF }

# cd したら自動的に pushd コマンドを実行する
setopt auto_pushd

# pushd したとき、重複したディレクトリをディレクトリスタックに追加しない
setopt pushd_ignore_dups

# ディレクトリスタックに保存するパスの最大数
DIRSTACKSIZE=100

# cdr (過去にcdコマンドで移動したことのあるディレクトリを記録して検索・移動できるコマンド・設定)
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-cdr
# https://qiita.com/yokarikeri/items/1c78edf32af41339ffec#-%E3%83%95%E3%82%A3%E3%83%AB%E3%82%BF%E3%83%AA%E3%83%B3%E3%82%B0%E3%83%84%E3%83%BC%E3%83%AB-peco、こういうcdrのパターンもある
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# -------------------------------------------------------------------------------------------
# 補完
# -------------------------------------------------------------------------------------------

# 補完機能を有効にする
autoload -Uz compinit

# cd -<tab> でディレクトリスタックに保存されたパスが補完候補に出てくる
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# ../ でカレントディレクトリをTab補完で表示しない
zstyle ':completion:*' ignore-parents parent pwd ..

# 履歴から補完を行う(入力途中でも可、例えば、ls のように入力した途中状態で Ctrl+p を押すと履歴中の ls で始まるコマンドを順次表示する、さらに押せばより古いコマンドを表示、やっぱりさっき(1つ前)の候補、というときはCtrl+nで戻る)
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# コマンドのスペルの訂正を使用する
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "

# 補完で小文字でも大文字にマッチさせる、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ファイル名の展開でディレクトリにマッチした場合、末尾に / を付加
setopt mark_dirs

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 補完が/で終わって、次が単語分割子か / かコマンドの後(;とか&)だったら、補完末尾の/を取る
setopt auto_remove_slash

# カッコの対応などを自動的に補完
setopt auto_param_keys

# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt glob_dots

# LS_COLORS環境変数の設定
eval $(dircolors $HOME/vm-dotfiles/zsh/dircolors/gruvbox.dircolors)

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする (select の後ろに =3 のように付けると、補完候補が3個以上ある時に選択出来るようになる)
zstyle ':completion:*:default' menu select

# = 以降でも補完できるようにする
setopt magic_equal_subst

# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# カーソル位置は保持したまま補完候補一覧を順次その場で表示
setopt always_last_prompt

# sudo の後ろでコマンド名を補完する (Ubuntuだと/etc/zsh/zshrcで設定されている)
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 補完候補を表示するときに出来るだけ詰めて表示
setopt list_packed

# 補完候補一覧でファイルの種別を末尾にマーク表示 (訳注:ls -F の記号と同じ)
setopt list_types

# 補完時にヒストリを自動的に展開
# setopt hist_expand

# 拡張グロブで補完 (パス名にマッチするワイルドカードパターンの拡張、#, ~, ^なども正規表現・パターンとして扱われるということ、例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
# setopt extended_glob

# オブジェクトファイルとか中間ファイルとかは file として補完させない
# zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# 補完候補をオプションやディレクトリで分けて表示する
# 補完関数の表示を強化する (https://qiita.com/syui/items/ed2d36698a5cc314557d)
# zstyle ':completion:*' verbose yes # 詳細な情報を使う
# zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history ### 補完方法の設定(指定した順番に実行する)
# zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
# zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
# zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
# zstyle ':completion:*:options' description 'yes'
# zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
# グループ名に空文字列を指定するとマッチ対象のタグ名がグループ名に使われる、従って、全てのマッチ種別を別々に表示させたいなら以下のようにする
# 補完方法毎にグループ化する
# zstyle ':completion:*' format '%B%F{blue}%d%f%b'
# zstyle ':completion:*' group-name ''

# 以下は fzf の曖昧検索で代用できる
# Ctrl+r で履歴のインクリメンタル検索(ワイルドカードも使える)、Ctrl+sで逆順 (Ctrl+s は プレフィックスキーと被る)
# bindkey '^r' history-incremental-pattern-search-backward
# bindkey '^s' history-incremental-pattern-search-forward

# -------------------------------------------------------------------------------------------
# ヒストリ
# -------------------------------------------------------------------------------------------

# メモリに保存される(検索対象と出来る)履歴の件数
HISTSIZE=10000

# 履歴において重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups

# 履歴からヒストリを展開する時に直接実行せず、一旦コマンドライン上に展開する
setopt hist_verify

# ヒストリ参照コマンドを履歴に追加しない
setopt hist_no_store

# 履歴登録時に、コマンドライン中の余分なスペースを削除する
setopt hist_reduce_blanks

# 履歴ファイルの保存先
HISTFILE=$HOME/.zsh_history

# 履歴ファイルに保存される履歴の件数
SAVEHIST=100000

# 履歴ファイルを複数のzshで共有(読み書き)する
setopt share_history
