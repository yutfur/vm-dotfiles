" -------------------------------------------------------------------------------------------
" 基本設定
" -------------------------------------------------------------------------------------------

" Vi互換を切る
set nocompatible

" 編集中ファイル名の表示
set title

" すべての数を10進数として扱う
set nrformats=

" 履歴を10000件保存
set history=1000

" テキストを隠さずに通常通り表示する
set conceallevel=0

" テキストを折りたたまない(トグル表示しない)
set nofoldenable

" ターミナルに戻った際カーソル形状を変えない
autocmd VimLeave * set guicursor=a:ver35

" python3 のパス
let g:python3_host_prog = '/usr/bin/python3'

" 置換の時 g オプションをデフォルトで有効にする
" set gdefault

" -------------------------------------------------------------------------------------------
" 文字コード
" -------------------------------------------------------------------------------------------
" バッファ内で扱う文字コード
set encoding=utf-8

" ファイル書き込み時の文字コード
set fileencoding=utf-8

" 読み込み時の文字コード(左側が優先される)
set fileencodings=utf-8,cp932

" 改行コード
set fileformats=unix,dos,mac

" Vim Scriptで使用するエンコード
scriptencoding utf-8

" -------------------------------------------------------------------------------------------
" 操作
" -------------------------------------------------------------------------------------------

" マウス操作を有効化
set mouse=a
" set ttymouse=xterm2

" 行頭/行末で左/右に移動した時に行をまたぐ移動をする
set whichwrap=b,s,h,l,<,>,[,],~

" 括弧対応ジャンプを強化
runtime macros/matchit.vi

" カーソルを行末まで移動可能にする
set virtualedit=onemore

" ヤンクでクリップボードにコピー
" xclip をインストールしておく
set clipboard+=unnamedplus

" ウィンドウ水平分割時に、下側をカレントウィンドウとする
set splitbelow

" ウィンドウ垂直分割時に、右側をカレントウィンドウとする
set splitright

" インサートモード終了時にIMEをオフ(fcitx、https://wonwon-eater.com/linux-vim-neovim-ime/)
if executable('fcitx5')
   autocmd InsertLeave * :call system('fcitx5-remote -c')
   autocmd CmdlineLeave * :call system('fcitx5-remote -c')
endif

" カレントディレクトリを自動で移動
" set autochdir

" -------------------------------------------------------------------------------------------
" Tabキー・インデント
" -------------------------------------------------------------------------------------------

" Tabキーで挿入される空白の幅(数値、半角スペースが基準)
set softtabstop=4

" インデントで挿入される空白の幅(数値、半角スペースが基準)
set shiftwidth=4

" softtabstopで設定されている値分の半角スペースが挿入されてもタブに変換しない (https://yu8mada.com/2018/08/26/i-ll-explain-vim-s-5-tab-and-space-related-somewhat-complicated-options-as-simply-as-possible/)
set expandtab

" 自動インデント (https://vim-jp.org/vimdoc-ja/options.html#'smartindent')
set smartindent
set autoindent

" -------------------------------------------------------------------------------------------
" 検索
" -------------------------------------------------------------------------------------------

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" 検索語をハイライト表示
set hlsearch

" -------------------------------------------------------------------------------------------
" 補完
" -------------------------------------------------------------------------------------------

" コマンドラインモードでTABキーによる補完を有効にする
set wildmenu
set wildmode=full

" -------------------------------------------------------------------------------------------
" ファイル
" -------------------------------------------------------------------------------------------

" スワップファイル有効化
set swapfile

" スワップファイル出力先
set directory=$HOME/.local/share/nvim/swap

" アンドゥファイル有効化
set undofile

" アンドゥファイル出力先
set undodir=$HOME/.local/share/nvim/undo

" 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden

" 保存されていないファイルがあるときは終了前に保存確認
set confirm

" 保存時に行末の空白を削除する
autocmd BufWritePre * :%s/\s\+$//ge

" ファイル形式の自動検出、ファイル用のプラグインとインデント設定を自動読み込みする
filetype plugin indent on

" 編集中のファイルが外部から変更された場合に読み直す
" set autoread

" ファイルブラウザーの開始時、バッファで開いているファイルのディレクトリを開く
" set browsedir=buffer

" -------------------------------------------------------------------------------------------
" ターミナル
" -------------------------------------------------------------------------------------------

" ESC でターミナルモードからノーマルモードへ
tnoremap <ESC> <C-\><C-n>

" 常にインサートモードでターミナルを開く
autocmd TermOpen * startinsert

" ターミナルモードで行番号を非表示
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
