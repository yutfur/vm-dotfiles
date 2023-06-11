# -------------------------------------------------------------------------------------------
# 関数
# -------------------------------------------------------------------------------------------

# < Ctrl + r > fzf でコマンド履歴検索して、選択したコマンドを展開(重複しているコマンドを除く、番号なし)
# https://htlsne.hatenablog.com/entry/2017/02/26/124131
function fzf-history-widget() {
    local tac=${commands[tac]:-"tail -r"}
    BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac | awk '!a[$0]++' | fzf +s)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N fzf-history-widget
bindkey '^r' fzf-history-widget

# fhコマンド fzf でコマンド履歴検索して、選択したコマンドを展開(重複しているコマンドを除く、番号なし)
fh() {
  local tac=${commands[tac]:-"tail -r"}
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac | awk '!a[$0]++' | fzf +s)
}

# < Alt + c > fzf で過去に cd で移動したディレクトリを検索して、選択したディレクトリに移動
# https://petitviolet.hatenablog.com/entry/20190708/1562544000)
function fzf_cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --preview 'f() { sh -c "ls -aF $1" }; f {}')
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  # zle clear-screen
}
zle -N fzf_cdr
bindkey '\ec' fzf_cdr

# fcdrコマンド fzf で過去に cd で移動したディレクトリを検索して、選択したディレクトリに移動
function fzf-cdr() {
    target_dir=`cdr -l | awk '{ print $2 }' | fzf --preview 'f() { sh -c "ls -aF $1" }; f {}'`
    target_dir=`echo ${target_dir/\~/$HOME}`
    if [ -n "$target_dir" ]; then
        cd $target_dir
    fi
}
alias fcdr='fzf-cdr'

# < Ctrl + t > fzf でカレントディレクトリ以下のファイル・ディレクトリをツリー表示でプレビューしながら曖昧検索して、選択したファイル・ディレクトリのパスをコマンドライン上に展開する
# https://petitviolet.hatenablog.com/entry/20190708/1562544000
function tree_select() {
  tree -N -a --charset=o -f -I '.git|.idea|resolution-cache|target/streams|node_modules' | \
    fzf --preview 'f() {
      set -- $(echo -- "$@" | grep -o "\./.*$");
      if [ -d $1 ]; then
        ls -aF $1
      else
        head -n 100 $1
      fi
    }; f {}' | \
      sed -e "s/ ->.*\$//g" | \
      tr -d '\||`| ' | \
      tr '\n' ' ' | \
      sed -e "s/--//g" | \
      xargs echo
}
function tree_select_buffer(){
  local SELECTED_FILE=$(tree_select)
  if [ -n "$SELECTED_FILE" ]; then
    LBUFFER+="$SELECTED_FILE"
    CURSOR=$#LBUFFER
    zle reset-prompt
  fi
}
zle -N tree_select_buffer
bindkey "^t" tree_select_buffer

# fpコマンド fzf でカレントディレクトリ以下のファイル・ディレクトリをツリー表示でプレビューしながら曖昧検索して、選択したファイル・ディレクトリのパスをコマンドライン上に展開する
# https://petitviolet.hatenablog.com/entry/20190708/1562544000
function fzf_tree_select() {
  tree -N -a --charset=o -f -I '.git|.idea|resolution-cache|target/streams|node_modules' | \
    fzf --preview 'f() {
      set -- $(echo -- "$@" | grep -o "\./.*$");
      if [ -d $1 ]; then
        ls -aF $1
      else
        head -n 100 $1
      fi
    }; f {}' | \
      sed -e "s/ ->.*\$//g" | \
      tr -d '\||`| ' | \
      tr '\n' ' ' | \
      sed -e "s/--//g" | \
      xargs echo
}
function fzf_tree_select_buffer(){
  local SELECTED_FILE=$(fzf_tree_select)
  if [ -n "$SELECTED_FILE" ]; then
    print -z $SELECTED_FILE
  fi
}
alias fp='fzf_tree_select_buffer'

# rgvi keyword と入力するとカレントディレクトリ以下で ripgrep を使って任意の文字列を全検索して、見つけたファイルをfzfで確認しつつnvimで開く
# https://zenn.dev/ulwlu/scraps/69926d20002f31
rgvi() {
  [ -z "$2" ] && matches=`rg "$1" -l`;
  [ -z "${matches}" ] && echo "no matches\n" && return 0;
  selected=`echo "${matches}" | fzf --preview "rg -pn '$1' {}"`;
  [ -z "${selected}" ] && echo "fzf Canceled." && return 0;
  nvim "${selected}";
}

# rgf コマンドを実行すると fzf のインターフェースで ripgrep
# https://zoshigayan.net/install-ripgrep/
rgf() {
  INITIAL_QUERY=""
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
         --ansi --phony --query "$INITIAL_QUERY" \
         --preview 'cat `echo {} | cut -f 1 --delim ":"`'
}

# Ctrl-zを使ってサスペンドしたら、Ctrl-zを使っても復帰できるようにする (fgでも復帰できる)
# https://postd.cc/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
